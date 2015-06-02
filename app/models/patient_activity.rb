class PatientActivity < ActiveRecord::Base
  belongs_to :patient
  belongs_to :patient_visit
  belongs_to :activity

  # In a case of cancelled invoice, another invoice can contain the patient_activity
  has_many :patient_activity_invoices, :dependent => :destroy
  has_many :invoices, through: :patient_activity_invoices

  #validates_presence_of :patient_id, unless: :patient_id?
  #validates_presence_of :clinical_trial_id, unless: :clinical_trial_id?
end
