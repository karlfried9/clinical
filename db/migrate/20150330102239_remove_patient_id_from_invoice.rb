class RemovePatientIdFromInvoice < ActiveRecord::Migration
  def change
    remove_column :invoices, :patient_id, :integer
  end
end
