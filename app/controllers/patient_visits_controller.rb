class PatientVisitsController < ApplicationController
  before_action :set_patient_visit, only: [:show, :edit, :update, :destroy]
  #before_action :set_clinical_trial_visit, only: [:edit_visit, :destroy_visit, :update_visit, :show_visit ]

  before_filter :authenticate_user!
  # GET /patient_visits
  # GET /patient_visits.json
  def index
    @patient_visit = PatientVisit.my(current_user)

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def load_visit
    @clinical_trial = ClinicalTrial.find(params[:clinical_trial_id])
    @patient = Patient.find(params[:patient_id])
    if @clinical_trial.present?
      visits = []
      @clinical_trial.visits.each do |visit|
        visit_data = {:id => visit[:id], :label => visit[:name],
                      :clinical_trial_id => visit[:clinical_trial_id],
                      :patient_visit => nil,
                      :patient_visit_schedule => nil}
        patient_visit = visit.get_patient_visit(@patient)
        patient_visit_schedule = visit.get_patient_visit_schedule(@patient)
        if patient_visit.present?
          visit_data[:patient_visit] = {:id => patient_visit.id, :recorded_date => patient_visit.recorded_date}
        end
        if patient_visit_schedule.present?
          visit_data[:patient_visit_schedule] = {:id => patient_visit_schedule.id, :schedule_date => patient_visit_schedule.schedule_date}
        end
        visits << visit_data
      end
      @visits_json = visits.to_json
    end

    @html_content = render_to_string "patient_visits/_visit_lists", :layout => false

    respond_to do |format|
      format.html { render :index}
      format.json { render json: { json: @visits_json, html: @html_content} }
    end
  end

  def add_visit_schedule
    @clinical_trial_visit = ClinicalTrialVisit.find(params[:clinical_trial_visit_id])
    @patient = Patient.find(params[:patient_id])

    # datepicker has the following format
    @date = Date.strptime(params[:date], '%Y-%m-%d')

    # @date = Date.strptime(params[:date], '%m/%d/%Y')
    @schedule = @clinical_trial_visit.get_patient_visit_schedule(@patient)
    if @schedule.nil?
      PatientVisitSchedule.create({:patient_id => @patient.id, :clinical_trial_visit_id => @clinical_trial_visit.id, :schedule_date => @date})
    else
      @schedule.schedule_date = @date
      @schedule.save
    end
    respond_to do |format|
      format.html { ""}
      format.json { render json: { success: true, message: "Schedule Updated Successfully."} }
    end
  end

  def record_visit
    @patient_visit = PatientVisit.new
    @clinical_trial_visit = ClinicalTrialVisit.find(params[:clinical_trial_visit_id])
    @patient = Patient.find(params[:patient_id])
    @activities = @clinical_trial_visit.activities
    @activities_json = @activities.map { |activity| {:id => activity.activity_id, :label => activity.activity.name,
                                                     :value => activity.activity.name,
                                                     :obj => { :id => activity.id, :activity_id => activity.activity_id,  :name => activity.activity.name, :category_list => activity.activity.category_list, :amount => activity.amount } } }.to_json

    @source_activities = Activity.where('organization_id = ?', @clinical_trial_visit.clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json
  end

  def new_visit
    @clinical_trial_visit = ClinicalTrialVisit.find(params[:clinical_trial_visit_id])
    @patient = Patient.find(params[:patient_id])
    @activities = params[:activities]
    @activities_json = @activities.map { |activity| {:id => activity[:id], :label => activity[:name],
                                                     :value => activity[:name],
                                                     :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name], :category_list => activity[:category_list], :amount => activity[:amount], :performed => activity[:performed], :billable => activity[:billable]} } }.to_json

    @source_activities = Activity.where('organization_id = ?', @clinical_trial_visit.clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json

    if @clinical_trial_visit.get_patient_visit(@patient).present?
      redirect_to :action => 'load_visit', :clinical_trial_id => @clinical_trial_visit.clinical_trial.id,
                  :patient_id => @patient.id
    end

    if @clinical_trial_visit
      @patient_visit = PatientVisit.new(visit_params)
      @patient_visit.patient_id = @patient.id
      @patient_visit.clinical_trial_visit_id = @clinical_trial_visit.id
      @patient_visit.clinical_trial_id = @clinical_trial_visit.clinical_trial_id
      @patient_visit.recorded_date = DateTime.now
      if @patient_visit.save
        @activities.each do |param|
          activity = PatientActivity.new
          activity.patient_id = @patient.id
          activity.patient_visit_id = @patient_visit.id
          activity.activity_id = param[:activity_id]
          activity.amount = param[:amount]
          if param[:billable]
            activity.billable = true
          else
            activity.billable = false
          end

          if param[:performed]
            activity.performed = true
          else
            activity.performed = false
          end
          activity.save
        end
      end
    end
    redirect_to :action => 'load_visit', :clinical_trial_id => @clinical_trial_visit.clinical_trial.id,
                :patient_id => @patient.id
  end

  def update_visit
    @clinical_trial_visit = ClinicalTrialVisit.find(params[:clinical_trial_visit_id])

    @source_activities = Activity.where('organization_id = ?', @clinical_trial_visit.clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json

    @patient = Patient.find(params[:patient_id])
    @activities = params[:activities]
    @activities_json = @activities.map { |activity| {:id => activity[:id], :label => activity[:name],
                                                     :value => activity[:name],
                                                     :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name], :category_list => activity[:category_list], :amount => activity[:amount], :performed => activity[:performed], :billable => activity[:billable]} } }.to_json
    @patient_visit = PatientVisit.where('clinical_trial_visit_id = ?', @clinical_trial_visit.id).first

    if @patient_visit
      @patient_visit.description = params[:patient_visit][:description]
      @patient_visit.recorded_date = DateTime.now
      if @patient_visit.save
        @removed_activities = @patient_visit.activities.where('id NOT IN(?)', params[:activities].map {|param| param[:id].to_i})
        @removed_activities.destroy_all
        @activities.each do |param|
          if param[:id].present?
            activity = PatientActivity.find(param[:id])
            activity.amount = param[:amount]
            if param[:billable]
              activity.billable = true
            else
              activity.billable = false
            end
            if param[:performed]
              activity.performed = true
            else
              activity.performed = false
            end
          else
            activity = PatientActivity.new
            activity.patient_id = @patient.id
            activity.patient_visit_id = @patient_visit.id
            activity.activity_id = param[:activity_id]
            activity.amount = param[:amount]
            if param[:billable]
              activity.billable = true
            else
              activity.billable = false
            end
            if param[:performed]
              activity.performed = true
            else
              activity.performed = false
            end
          end
          activity.save
        end
      end
    end
    redirect_to :action => 'load_visit', :clinical_trial_id => @clinical_trial_visit.clinical_trial.id,
                                              :patient_id => @patient.id
  end

  def edit_visit
    @clinical_trial_visit = ClinicalTrialVisit.find(params[:clinical_trial_visit_id])
    @patient = Patient.find(params[:patient_id])
    @patient_visit = @clinical_trial_visit.get_patient_visit(@patient)
    @activities = @patient_visit.activities
    @activities_json = @activities.map { |activity| {:id => activity.activity_id, :label => activity.activity.name,
                                                     :value => activity.activity.name,
                                                     :obj => { :id => activity.id, :patient_visit_id => activity.patient_visit_id,
                                                               :activity_id => activity.activity_id,  :name => activity.activity.name,
                                                               :category_list => activity.activity.category_list,
                                                               :amount => activity.amount,
                                                               :billable => activity.billable,
                                                               :performed => activity.performed} } }.to_json

    @source_activities = Activity.where('organization_id = ?', @clinical_trial_visit.clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json

  end

  def show_visit
    @clinical_trial_visit = ClinicalTrialVisit.find(params[:clinical_trial_visit_id])
    @patient = Patient.find(params[:patient_id])
    @patient_visit = @clinical_trial_visit.get_patient_visit(@patient)
    @activities = @patient_visit.activities
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def visit_params
      params.require(:patient_visit).permit(:description)
    end

    def set_patient_visit
      @patient_visit = PatientVisit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_visit_params
      params[:patient_visit]
    end
end
