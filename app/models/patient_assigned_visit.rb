class PatientAssignedVisit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :clinical_trial_visit
end
