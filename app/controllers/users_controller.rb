class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @users = policy_scope(User)
    authorize User
    respond_with(@users)
  end

  def show
    authorize @user
    respond_with(@user)
  end

  # GET
  # create clinic manager page
  def new_clinic_manager
    authorize User
    @user = User.new
    @user.set_role("Clinic Manager")
    respond_with(@user)
  end

  # GET
  # create doctor page
  def new_doctor
    authorize User
    @user = User.new
    @user.set_role("Doctor")
    # set organization id to form
    @user.organization_id = current_user.organization_id
    respond_with(@user)
  end

  def edit
    authorize @user
    respond_with(@user)
  end

  def create_user
    @user = User.new(user_params)
    authorize @user
    if @user.save
      respond_with(@user)
    else
      if @user.clinic_manager?
        render :new_clinic_manager
      else
        render :new_doctor
      end
    end
  end

  def update
    authorize @user
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    authorize @user
    @user.destroy
    respond_with(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def secure_params
    params.require(:user).permit(:role)
  end

  def user_params
    params.require(:user).permit(:role_id, :email, :name, :password, :password_confirmation, :organization_id)
  end

end
