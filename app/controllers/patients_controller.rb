class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html, :xlsx

  def index
    @patients = policy_scope(Patient).paginate(:page => params[:page], :per_page => 50).order('id ASC')

    respond_with(@patients)
  end

  def patient_list
    @patients = Patient.my(current_user)
    respond_to do |format|
      format.xlsx
    end

  end
  def show
    authorize @patient
    respond_with(@patient)
  end

  def new
    authorize Patient
    @patient = Patient.new
    if current_user.super_admin?
      @patient.organization_id = 1
    end
    respond_with(@patient)
  end

  def edit
    authorize @patient
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.save
    respond_with(@patient)
  end

  def update
    authorize @patient
    @patient.update(patient_params)
    respond_with(@patient)
  end

  def destroy
    authorize @patient
    @patient.destroy
    respond_with(@patient)
  end

  private
  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:organization_id, :salutation, :first_name, :last_name, :patient_id, :date_of_birth, :notes, :clinical_trial_id, :arm_id)
  end

end
