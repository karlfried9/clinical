class ActivitiesController < ApplicationController

  # todo: Security issue, can create/update activities for other organization.  Organization id is hidden field in forms
  # todo: Activity scope to current user org
before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  #autocomplete :activity, :name, :extra_data => [:amount]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    @activity.currency_code = "EU"
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: t('activity.flash_successfully_created') }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: t('activity.flash_successfully_updated') }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: t('activity.flash_successfully_deleted') }
      format.json { head :no_content }
    end
  end

  def autocomplete_activity_name
    term = params[:term]
    activities = Activity.where('name LIKE ?', "%#{term}%").order(:name).all
    #render :json => activities.map { |activity| {:id => activity.id, :name => activity.name, :category_list => activity.category_list, :amount => activity.amount} }
    render :json => activities.map { |activity| {:id => activity.id, :label => activity.name,
                                                 :value => activity.name,
                                                 :obj => { :id => activity.id, :name => activity.name, :category_list => activity.category_list, :amount => activity.amount } } }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:organization_id, :type_id, :category_list, :name, :code_type, :currency_code, :code, :billable, :amount, :description)
    end
end
