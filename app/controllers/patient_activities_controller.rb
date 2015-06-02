class PatientActivitiesController < ApplicationController
  before_action :set_patient_activity, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def monthly_charge_report
    @clinical_trials = ClinicalTrial.my(current_user)
    if params[:clinical_trial_id]
      @clinical_trial = ClinicalTrial.find(params[:clinical_trial_id])
    end
    @connection = ActiveRecord::Base.connection
    @query = "select extract(year from patient_visits.recorded_date) as year_charged, extract(month from patient_visits.recorded_date) as month_charged,
      sum(patient_activities.amount) as total_charged
      from patient_activities inner join patient_visits on patient_activities.patient_visit_id = patient_visits.id
      where patient_visits.clinical_trial_id = ? and patient_activities.billable = true
      group by 1, 2
      order by 1, 2"
  end

  def reports_clinical_trial_progress_report
    @clinical_trials = ClinicalTrial.my(current_user)
    if params[:clinical_trial_id]
      @clinical_trial = ClinicalTrial.find(params[:clinical_trial_id])
    end
  end
  def enrollment_report
    # for each clinical trial show total enrollment expected vs. actual patients number in the trial
    # show bar chart of patients Not enrolled, visit 1, visit 2, visit 3, end of study
    
  end
  
  def index
    @patient_activities = PatientActivity.all
    respond_with(@patient_activities)
  end

  def show
    respond_with(@patient_activity)
  end

  def new
    @patient_activity = PatientActivity.new
    respond_with(@patient_activity)
  end

  def edit
  end

  def create
    @patient_activity = PatientActivity.new(patient_activity_params)
    @patient_activity.save
    respond_with(@patient_activity)
  end

  def update
    @patient_activity.update(patient_activity_params)
    respond_with(@patient_activity)
  end

  def destroy
    @patient_activity.destroy
    respond_with(@patient_activity)
  end

  private
    def set_patient_activity
      @patient_activity = PatientActivity.find(params[:id])
    end

    def patient_activity_params
      params.require(:patient_activity).permit(:patient_id, :clinical_trial_id, :activity_date, :body_part, :prescription_written, :prescription_notes, :amount_charged)
    end
end
