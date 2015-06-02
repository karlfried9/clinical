class TrialSponsorsController < ApplicationController
  before_action :set_trial_sponsor, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @trial_sponsors = TrialSponsor.all
    respond_with(@trial_sponsors)
  end

  def show
    respond_with(@trial_sponsor)
  end

  def new
    @trial_sponsor = TrialSponsor.new
    respond_with(@trial_sponsor)
  end

  def edit
  end

  def create
    @trial_sponsor = TrialSponsor.new(trial_sponsor_params)
    @trial_sponsor.save
    respond_with(@trial_sponsor)
  end

  def update
    @trial_sponsor.update(trial_sponsor_params)
    respond_with(@trial_sponsor)
  end

  def destroy
    @trial_sponsor.destroy
    respond_with(@trial_sponsor)
  end

  private
    def set_trial_sponsor
      @trial_sponsor = TrialSponsor.find(params[:id])
    end

    def trial_sponsor_params
      params.require(:trial_sponsor).permit(:name, :contact_info)
    end
end
