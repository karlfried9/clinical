require 'spec_helper'

describe ClinicalTrialPolicy do

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:doctor) { FactoryGirl.build_stubbed :user }
  let (:clinic_manager) { FactoryGirl.build_stubbed :clinic_manager }
  let (:admin) { FactoryGirl.build_stubbed :super_admin }

  subject { ClinicalTrialPolicy }

end
