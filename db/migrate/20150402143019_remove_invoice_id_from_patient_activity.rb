class RemoveInvoiceIdFromPatientActivity < ActiveRecord::Migration
  def change
    remove_column :patient_activities, :invoice_id, :integer
  end
end
