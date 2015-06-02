class Patient < ActiveRecord::Base
  belongs_to :organization
  belongs_to :clinical_trial
  belongs_to :arm
  has_many :patient_visits
  has_many :patient_activities

  validates_presence_of :organization_id, :first_name, :last_name, :salutation, :patient_id, :date_of_birth

  scope :my, ->(current_user) {
    where(:organization_id => current_user.organization_id)
  }

  def get_unrecorded_visits
    if self.clinical_trial.present?
      visits =
      self.patient_visits
    end
  end

  def full_name
    return self.salutation + " " + self.first_name + " " + self.last_name
  end
end
