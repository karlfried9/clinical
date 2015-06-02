class ClinicalTrialVisit < ActiveRecord::Base
  belongs_to :clinical_trial
  belongs_to :visit_type, class_name: "ClinicalTrialVisitType", foreign_key: "type_id"
  belongs_to :visit_format, class_name: "ClinicalTrialVisitFormat", foreign_key: "format_id"
  belongs_to :after_visit, class_name: "ClinicalTrialVisit", foreign_key: "after_visit_id"

  has_many :activities, class_name: "ClinicalTrialActivity", foreign_key: "clinical_trial_visit_id", :dependent => :destroy
  has_many :arms, class_name: "Arm"
  has_many :patient_visits
  has_many :patient_visit_schedules

  #validate :name, presence: true
  #validate :clinical_trial_id, presence: true
  #validate :format, presence: true
  #validate :clinical_trial_visit_type_id, presence: true

  def get_patient_visit(patient)
    self.patient_visits.where('patient_id = ?', patient.id).first
  end

  def get_patient_visit_schedule(patient)
    self.patient_visit_schedules.where('patient_id = ?', patient.id).first
  end

  def total_amount
    amount = 0
    self.activities.each do |activity|
      amount += activity.amount
    end
    return amount
  end
end
