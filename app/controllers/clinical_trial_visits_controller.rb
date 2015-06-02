class ClinicalTrialVisitsController < ApplicationController
  before_action :set_clinical_trial_visit, only: [:show, :edit, :update, :destroy]

  autocomplete :clinical_trial_visit, :name

  # GET /clinical_trial_visits
  # GET /clinical_trial_visits.json
  def index
    @clinical_trial_visits = ClinicalTrialVisit.all
  end

  # GET /clinical_trial_visits/1
  # GET /clinical_trial_visits/1.json
  def show
  end

  # GET /clinical_trial_visits/new
  def new
    @clinical_trial_visit = ClinicalTrialVisit.new
  end

  # GET /clinical_trial_visits/1/edit
  def edit
  end

  # POST /clinical_trial_visits
  # POST /clinical_trial_visits.json
  def create
    @clinical_trial_visit = ClinicalTrialVisit.new(clinical_trial_visit_params)

    respond_to do |format|
      if @clinical_trial_visit.save
        format.html { redirect_to @clinical_trial_visit, notice: t('clinical_trial.flash_successfully_created') }
        format.json { render :show, status: :created, location: @clinical_trial_visit }
      else
        format.html { render :new }
        format.json { render json: @clinical_trial_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinical_trial_visits/1
  # PATCH/PUT /clinical_trial_visits/1.json
  def update
    respond_to do |format|
      if @clinical_trial_visit.update(clinical_trial_visit_params)
        format.html { redirect_to @clinical_trial_visit, notice: t('clinical_trial.flash_successfully_updated') }
        format.json { render :show, status: :ok, location: @clinical_trial_visit }
      else
        format.html { render :edit }
        format.json { render json: @clinical_trial_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinical_trial_visits/1
  # DELETE /clinical_trial_visits/1.json
  def destroy
    @clinical_trial_visit.destroy
    respond_to do |format|
      format.html { redirect_to clinical_trial_visits_url, notice: t('clinical_trial.flash_successfully_deleted') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinical_trial_visit
      @clinical_trial_visit = ClinicalTrialVisit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinical_trial_visit_params
      params[:clinical_trial_visit]
    end
end
