class PatientActivityInvoice < ActiveRecord::Base
  belongs_to :patient_activity
  belongs_to :invoice
end
