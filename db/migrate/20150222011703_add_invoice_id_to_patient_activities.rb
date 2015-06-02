class AddInvoiceIdToPatientActivities < ActiveRecord::Migration
  def change
    add_reference :patient_activities, :invoice, index: true
    add_foreign_key :patient_activities, :invoices
  end
end
