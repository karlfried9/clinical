class ClinicalTrialsController < ApplicationController
  
  @trials = %w["Phase I" "Phase II"]
  before_action :set_clinical_trial, only: [:show, :edit, :update, :destroy, :add_arm, :manage_arms, :destroy_arm, :update_arm,
                                            :manage_visits, :new_visit, :add_visit, :edit_visit, :destroy_visit, :update_visit, :show_visit,
                                            :load_arms, :load_patients, :add_attachment, :remove_attachment]
  before_action :set_clinical_trial_visit, only: [:edit_visit, :destroy_visit, :update_visit, :show_visit ]

  before_filter :authenticate_user!

  respond_to :html

  def index
    @clinical_trials = policy_scope(ClinicalTrial).paginate(:page => params[:page], :per_page => 25).order('id ASC')
    respond_with(@clinical_trials)
    #@clinical_trials_grid = initialize_grid(@clinical_trials)
  end

  def show
    authorize @clinical_trial
    @clinical_trial_attachment = ClinicalTrialAttachment.new
    respond_with(@clinical_trial)
  end

  def new
    @clinical_trial = ClinicalTrial.new
    if current_user.super_admin?
      @clinical_trial.organization_id = 1
    end
    respond_with(@clinical_trial)
  end

  def edit
    authorize @clinical_trial
  end

  def create
    @clinical_trial = ClinicalTrial.new(clinical_trial_params)
    @clinical_trial.save
    respond_with(@clinical_trial)
  end

  def update
    authorize @clinical_trial
    @clinical_trial.update(clinical_trial_params)
    respond_with(@clinical_trial)
  end

  def destroy
    authorize @clinical_trial
    @clinical_trial.destroy
    respond_with(@clinical_trial)
  end

  # arm actions

  def manage_arms

  end

  def add_arm
    arm = Arm.new(arm_params)
    arm.clinical_trial_id = @clinical_trial.id
    arm.save
    #redirect_to manage_arms_clinical_trial_path(@clinical_trial)
    redirect_to clinical_trial_path(@clinical_trial)
  end

  def update_arm
    @arm = Arm.find(params[:arm][:id])
    @arm.update(arm_params)
    redirect_to manage_arms_clinical_trial_path(@clinical_trial)
  end

  def destroy_arm
    @arm = Arm.find(params[:arm_id])
    @arm.destroy
    redirect_to manage_arms_clinical_trial_path(@clinical_trial)
  end

  def load_arms
    render :json => @clinical_trial.arms
  end

  def load_patients
    render :json => @clinical_trial.patients
  end

  # visits actions
  def manage_visits

  end

  def show_visit

  end

  def new_visit
    @clinical_trial_visit = ClinicalTrialVisit.new
    @source_activities = Activity.where('organization_id = ?', @clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                     :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                               :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json
  end

  def add_visit
    @source_activities = Activity.where('organization_id = ?', @clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json

    @clinical_trial_visit = ClinicalTrialVisit.new(clinical_trial_visit_params)
    @clinical_trial_visit.clinical_trial_id = @clinical_trial.id
    @activities = params[:activities]
    @activities_json = @activities.map { |activity| {:id => activity[:id], :label => activity[:name],
                                                     :value => activity[:name],
                                                     :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                               :category_list => activity[:category_list], :amount => activity[:amount] } } }.to_json
    if @clinical_trial_visit.save
      @activities.each do |param|
        #activity = ClinicalTrialActivity.new(param)
        activity = ClinicalTrialActivity.new
        activity.clinical_trial_visit_id = @clinical_trial_visit.id
        activity.activity_id = param[:activity_id]
        activity.amount = param[:amount]
        activity.save
      end
    end
    redirect_to manage_visits_clinical_trial_path(@clinical_trial)
  end

  def destroy_visit
    @clinical_trial_visit.destroy
    redirect_to manage_visits_clinical_trial_path(@clinical_trial)
  end

  def edit_visit
    @source_activities = Activity.where('organization_id = ?', @clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json

    @activities = @clinical_trial_visit.activities
    @activities_json = @activities.map { |activity| {:id => activity.activity_id, :label => activity.activity.name,
                                                    :value => activity.activity.name,
                                                    :obj => { :id => activity.id, :activity_id => activity.activity_id,
                                                              :name => activity.activity.name, :category_list => activity.activity.category_list,
                                                              :amount => activity.amount } } }.to_json

  end

  def update_visit
    @source_activities = Activity.where('organization_id = ?', @clinical_trial.organization.id)
    @source_activities_json = @source_activities.map { |activity| {:id => activity[:id],
                                                                   :obj => { :id => activity[:id], :activity_id => activity[:id],  :name => activity[:name],
                                                                             :category_list => activity.category_list, :amount => activity[:amount] } } }.to_json

    @clinical_trial_visit.update(clinical_trial_visit_params)
    # update activities
    @removed_activities = @clinical_trial_visit.activities.where('id NOT IN(?)', params[:activities].map {|param| param[:id].to_i})
    @removed_activities.destroy_all
    @activities = params[:activities]
    @activities.each do |param|
      if param[:id].present?
        activity = ClinicalTrialActivity.find(param[:id])
        activity.amount = param[:amount]
      else
        activity = ClinicalTrialActivity.new
        activity.clinical_trial_visit_id = @clinical_trial_visit.id
        activity.activity_id = param[:activity_id]
        activity.amount = param[:amount]
      end
      activity.save
    end
    redirect_to manage_visits_clinical_trial_path(@clinical_trial)
  end

  def add_attachment
    if params['clinical_trial_attachment'].nil?
      redirect_to clinical_trial_path(@clinical_trial), :alert => t('clinical_trial.attachment_error_select_file')
      return
    end
    @clinical_trial_attachment = ClinicalTrialAttachment.new(clinical_trial_attachment_params)
    @clinical_trial_attachment.clinical_trial_id = @clinical_trial.id
    @clinical_trial_attachment.save
    redirect_to clinical_trial_path(@clinical_trial)
  end

  def remove_attachment
    @clinical_trial_attachment = ClinicalTrialAttachment.where(id: params[:attachment_id])
    if @clinical_trial_attachment.present?
      @clinical_trial_attachment.first.destroy
    end
    redirect_to clinical_trial_path(@clinical_trial)
  end

  private
    def set_clinical_trial
      @clinical_trial = ClinicalTrial.find(params[:id])
    end

    def set_clinical_trial_visit
      @clinical_trial_visit = ClinicalTrialVisit.find(params[:visit_id])
    end

    def clinical_trial_params
      params.require(:clinical_trial).permit(:trial_sponsor_id, :organization_id, 
      :protocol_id, :study_title, :phase_id, :status_id, :drug_name, :organ_id,
      :disease_stage_id, :study_acronym, :official_study_title, :secondary_ids,
      :enrollment_begin_date, :enrollment_end_date, :expected_trial_enrollment_count,
      :primary_completion_date, :study_completion_date, :masking_id,
      :overall_study_status_id, :recruitment_status_at_facility_id,
      :principal_investigator, :clinical_assistant, :other_information, :start_date)
    end

    def arm_params
      params.require(:arm).permit(:name, :description)
    end

    def clinical_trial_visit_params
      params.require(:clinical_trial_visit).permit(:name, :description, :type_id, :format_id, :offset_days,
                                                   :after_visit_id, :tolerance_number_of_days)
    end

    def clinical_trial_attachment_params
      params.require(:clinical_trial_attachment).permit(:content)
    end


end
