class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.super_admin?
        scope.all
      elsif @user.clinic_manager?
        scope.joins(:role).where("organization_id = ? and roles.name!='Clinic Manager'", @user.organization_id )
      else
        scope.joins(:role).where("organization_id = ? and roles.name!='Clinic Manager'", @user.organization_id )
      end
    end
  end

  def index?
    true
  end

  def new_doctor?
    @user.super_admin? or @user.clinic_manager?
  end

  def new_clinic_manager?
    @user.super_admin?
  end

  def create_user?
    @user.super_admin? or (@user.clinic_manager? and @record.doctor?)
  end

  def show?
    @user.super_admin? or (@user.clinic_manager? and @user.organization_id == @record.organization_id) or @user == @record
  end

  def update?
    @user.super_admin? or (@user.clinic_manager? and @user.organization_id == @record.organization_id and !@record.super_admin? and !@record.clinic_manager?) or @user == @record
  end

  def destroy?
    return false if @user == @record
    @user.super_admin? or (@user.clinic_manager? and @user.organization_id == @record.organization_id and !@record.super_admin? and !@record.clinic_manager?)
  end

end
