class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    authorize Organization
    @organizations = Organization.all
    respond_with(@organizations)
  end

  def show
    authorize @organization
    respond_with(@organization)
  end

  def new
    authorize Organization
    @organization = Organization.new
    respond_with(@organization)
  end

  def edit
    authorize @organization
  end

  def create
    authorize Organization
    @organization = Organization.new(organization_params)
    @organization.save
    respond_with(@organization)
  end

  def update
    authorize @organization
    @organization.update(organization_params)
    respond_with(@organization)
  end

  def destroy
    authorize @organization
    @organization.destroy
    respond_with(@organization)
  end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name)
    end
end
