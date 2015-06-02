require 'spec_helper'

describe PatientPolicy do

  subject { PatientPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:doctor) { FactoryGirl.build_stubbed :user }
  let (:clinic_manager) { FactoryGirl.build_stubbed :clinic_manager }
  let (:admin) { FactoryGirl.build_stubbed :super_admin }

  permissions :create? do
    it "allows access for an super admin" do
      expect(subject).to permit(admin)
    end
  end
end
