class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :add_comment, :issue, :send_state, :archive, :cancel, :generate_pdf]
  before_filter :authenticate_user!

  respond_to :html, :json, :xlsx

  def index
    # get the paginated invoices list
    if(params[:status])
      @invoices = Invoice.my(current_user).where("status=? and clinical_trial_id is not ?", params[:status], nil).paginate(:page => params[:page], :per_page => 3)
      @status = params[:status]
    else
      @invoices = Invoice.my(current_user).where('clinical_trial_id is not ?', nil).paginate(:page => params[:page], :per_page => 3)
      @status = "all"
    end
    @states = Invoice.state_machines[:status].states.map &:name

    # get the list of uninvoiced patient activities, including cancelled invoice.
    # @uninvoiced_clinical = ClinicalTrial.where.not(:id => Invoice.my(current_user).where.not(:status => "cancelled").select(:clinical_trial_id))
    @uninvoiced_clinical = []
    @uninvoiced = ClinicalTrial.where(:id => Patient.where(:id => PatientActivity.where.not(:id => PatientActivityInvoice.select(:patient_activity_id)).select(:patient_id)).select(:clinical_trial_id))
    @uninvoiced.each do |clinical|
      activities = []
      clinical.patients.each do |patient|
        activities |= patient.patient_activities.where.not(:id => PatientActivityInvoice.select(:patient_activity_id))
      end
      @uninvoiced_clinical << {:id => clinical.id, :name => clinical.study_title, :count => activities.count, :amount => activities.map(&:amount).inject(0, &:+)}
    end

    @payment = Payment.new
    respond_with(@invoices)
  end

  def show
    # estimate the total charged amount, which is sum of the amount of the activities
    @total_amount = 0
    @invoice.patient_activities.each do |activity|
      @total_amount = @total_amount + activity.amount
    end

    @paid_amount = 0
    @invoice.payments.each do |pay|
      @paid_amount = @paid_amount + pay.amount
    end

    @payment = Payment.new
    respond_with(@invoice)
  end

  def new
    @invoice = Invoice.new

    # get the clinical trial ID from parameter, so it can be displayed once screen loads
    @invoice.clinical_trial_id = params[:clinical_trial_id]

    # get the uninvoiced list of patient activities
    @activities = PatientActivity.where.not(:id => PatientActivityInvoice.where(:invoice_id => Invoice.my(current_user).where.not(:status => "cancelled").select(:id)).select(:patient_activity_id))


    # get the list of clinical trials which have same organization id as current user's organization id
    if(current_user.organization.nil?)
      @clinical_trials = ClinicalTrial.all
    else
      @clinical_trials = ClinicalTrial.where(:organization_id => current_user.organization_id)
    end

    respond_with(@invoice)
  end

  def edit
    # get the list of activities which are uninvoiced(,including cancelled invoice) or already invoiced to @invoice.
    @activities = @invoice.patient_activities | PatientActivity.where.not(:id => PatientActivityInvoice.where(:invoice_id => Invoice.my(current_user).where.not(:status => "cancelled").select(:id)).select(:patient_activity_id))

    # get the list of clinical trials which have same organization id as current user's organization id
    if(current_user.organization.nil?)
      @clinical_trials = ClinicalTrial.all
    else
      @clinical_trials = ClinicalTrial.where(:organization_id => current_user.organization_id)
    end

    respond_with(@invoice)
  end

  def create
    # if current invoice is valid, save it to database
    @invoice = Invoice.new(invoice_params)
    if @invoice.valid?
      @invoice.save

      # save the list of uninvoiced activities

      unless(params['activity'].nil?)
        params['activity'].each do |activity_id|
          activity = PatientActivity.where(:id => activity_id[0]).first
          if (!activity.nil?)
            @invoice.patient_activities << activity
          end
        end
      end

      # update Billing Info

      if(params['billing_from'] && params['billing_to'])
        if(!@invoice.clinical_trial.nil? && !@invoice.clinical_trial.organization.nil?)
          @invoice.clinical_trial.organization.update_column(:billing_from, params['billing_from'])
          @invoice.clinical_trial.update_column(:billing_to, params['billing_to'])
        end
      end

      # set current organizaion to current invoice
      @invoice.update_column(:organization_id, current_user.organization_id)

      # update the status of invoice
      @invoice.issue

      respond_with(@invoice)
    end
  end

  def update
    # format the list of activities, since there are no relation between before and after
    @invoice.patient_activities.delete_all

    # save the list of uninvoiced activities
    unless(params['activity'].nil?)
      params['activity'].each do |activity_id|
        activity = PatientActivity.where(:id => activity_id[0]).first
        if (!activity.nil?)
          @invoice.patient_activities << activity
        end
      end
    end

    # update billing info
    if(params['billing_from'] && params['billing_to'])
      if(!@invoice.clinical_trial.nil? && !@invoice.clinical_trial.organization.nil?)
        @invoice.clinical_trial.organization.update_column(:billing_from, params['billing_from'])
        @invoice.clinical_trial.update_column(:billing_to, params['billing_to'])
      end
    end

    @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  def clinical_trial_billinginfo
    # get the current clinical trial's billing info
    clinical_trial = ClinicalTrial.where(:id => params[:clinical_trial_id]).first
    @billing_from = clinical_trial.organization.billing_from
    @billing_to = clinical_trial.billing_to

    @billing_array = [@billing_from, @billing_to]
    # in most cases, respond with json format
    respond_to do |format|
      format.html { render :clinical_trial_billinginfo }
      format.json { render :json => @billing_array.to_json}
    end
  end

  def add_comment
    # add comment from parameters
    save_comment @invoice, params[:comment]

    redirect_to invoice_path(@invoice)
  end

  def generate_pdf
    @total_amount = 0
    @invoice.patient_activities.each do |activity|
      @total_amount = @total_amount + activity.amount
    end

    @paid_amount = 0
    @invoice.payments.each do |pay|
      @paid_amount = @paid_amount + pay.amount
    end

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "invoice"   # Excluding ".pdf" extension.
      end
    end
  end

  def issue
    pre_status = t("invoice." + @invoice.status)
    if(@invoice.issue)
      cur_status = t("invoice." + @invoice.status)
      save_comment @invoice, " #{pre_status} --> #{cur_status}"
    end

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def send_state
    pre_status = t("invoice." + @invoice.status)
    if(@invoice.send_state)
      cur_status = t("invoice." + @invoice.status)
      save_comment @invoice, " #{pre_status} --> #{cur_status}"
    end

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def archive
    pre_status = t("invoice." + @invoice.status)
    if(@invoice.archive)
      cur_status = t("invoice." + @invoice.status)
      save_comment @invoice, " #{pre_status} --> #{cur_status}"
    end

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def record_payment
    @invoice = Invoice.my(current_user).where(:id => params[:invoice_id]).first
    @payment = Payment.new(payment_params)

    # Calculate charged amount and paid amount
    @total_amount = 0
    @invoice.patient_activities.each do |activity|
      @total_amount = @total_amount + activity.amount
    end

    @paid_amount = 0
    @invoice.payments.each do |payment|
      @paid_amount = @paid_amount + payment.amount
    end

    if(@payment.amount + @paid_amount <= @total_amount)
      #save payment
      @payment.save

      #make association between payment and invoice
      @invoice.payments << @payment

      @paid_amount = 0
      @invoice.payments.each do |payment|
        @paid_amount = @paid_amount + payment.amount
      end

      save_comment @invoice, t('invoice.payment_recieved') + ": "+ ActionController::Base.helpers.number_to_currency(@payment.amount)

      pre_status = t("invoice." + @invoice.status)

      if(@total_amount <= @paid_amount)
        if(@invoice.full_payment)
          cur_status = t("invoice." + @invoice.status)
          save_comment @invoice, " #{pre_status} --> #{cur_status}"
        end
      else
        if(@invoice.partial_payment)
          cur_status = t("invoice." + @invoice.status)
          save_comment @invoice, " #{pre_status} --> #{cur_status}"
        end
      end
    end

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def cancel
    pre_status = t("invoice." + @invoice.status)
    if(@invoice.cancel)
      cur_status = t("invoice." + @invoice.status)
      save_comment @invoice, " #{pre_status} --> #{cur_status}"
    end

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def save_comment(invoice, content)
    # add comment from parameters
    commentable = invoice
    comment = commentable.comments.create
    comment.title = "Comments in invoice " + invoice.id.to_s
    comment.comment = "<b>" + current_user.email + "</b>"+ ": " + content
    comment.save
  end

  def set_invoice
    @invoice = Invoice.my(current_user).find(params[:id])

  end

  def invoice_params
    params.require(:invoice).permit(:clinical_trial_id, :description, :status, :created_date, :dateoption, :fromdate, :todate, :mailing_address, :notes, :patient_activity_ids)
  end

  def payment_params
    params.require(:payment).permit(:amount, :currency_code)
  end
end
