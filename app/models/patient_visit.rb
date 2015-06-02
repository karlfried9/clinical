class PatientVisit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :clinical_trial_visit
  belongs_to :clinical_trial

  has_many :activities, class_name: "PatientActivity", :dependent => :destroy

  scope :my, ->(current_user) {
    joins(:clinical_trial).where("clinical_trials.organization_id" => current_user.organization_id)
  }

  #validate :name, presence: true
  #validate :clinical_trial_id, presence: true
  #validate :format, presence: true
  #validate :clinical_trial_visit_type_id, presence: true
end
