class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!
  def new
    redirect_to "/"
    #super
  end
  def create
    super
  end
end
