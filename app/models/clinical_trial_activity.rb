class ClinicalTrialActivity < ActiveRecord::Base
  belongs_to :clinical_trial_visit
  belongs_to :activity
end
