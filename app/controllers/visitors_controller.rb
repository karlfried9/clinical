class VisitorsController < ApplicationController
  #before_filter :authenticate_user!
  helper :all
  def index
    @resource = User.new
  end
end
