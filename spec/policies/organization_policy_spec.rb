require 'spec_helper'

describe OrganizationPolicy do

  subject { OrganizationPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:doctor) { FactoryGirl.build_stubbed :user }
  let (:clinic_manager) { FactoryGirl.build_stubbed :clinic_manager }
  let (:admin) { FactoryGirl.build_stubbed :super_admin }

  permissions :create? do
    it "allows create for an super admin" do
      expect(OrganizationPolicy).to permit(admin)
    end
    it "prevents doctor for an super admin" do
      expect(OrganizationPolicy).not_to permit(doctor)
    end
    it "prevents doctor for an super admin" do
      expect(OrganizationPolicy).not_to permit(clinic_manager)
    end
  end
end
