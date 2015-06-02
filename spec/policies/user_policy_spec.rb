require 'spec_helper'

describe UserPolicy do

  subject { UserPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:doctor) { FactoryGirl.build_stubbed :user }
  let (:clinic_manager) { FactoryGirl.build_stubbed :clinic_manager }
  let (:admin) { FactoryGirl.build_stubbed :super_admin }

  permissions :index? do
    it "allows access for an super admin" do
      expect(UserPolicy).to permit(admin)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your profile" do
      expect(subject).not_to permit(current_user, doctor)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting yourself" do
      expect(subject).not_to permit(current_user, current_user)
    end
    it "allows an clinic_manager to delete doctor" do
      expect(subject).to permit(clinic_manager, doctor)
    end
    it "prevent an clinic_manager to delete super admin" do
      expect(subject).not_to permit(clinic_manager, admin)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin, doctor)
    end
  end

end
