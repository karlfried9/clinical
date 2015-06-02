class ClinicalTrialPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.super_admin?
        scope.all
      else
        scope.where('organization_id = ?', @user.organization_id)
      end
    end
  end

  def index?
  end

  def show?
    @user.super_admin? or @user.organization_id == @record.organization_id
  end

  def new?
    true
  end

  def edit?
    @user.super_admin? or @user.organization_id == @record.organization_id
  end

  def create?
    @user.super_admin? or @user.organization_id == @record.organization_id
  end

  def update?
    @user.super_admin? or @user.organization_id == @record.organization_id
  end

  def destroy?
    @user.super_admin? or @user.organization_id == @record.organization_id
  end
end
