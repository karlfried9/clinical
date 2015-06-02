class CreatePatientActivityInvoices < ActiveRecord::Migration
  def change
    create_table :patient_activity_invoices do |t|
      t.integer :patient_activity_id
      t.integer :invoice_id

      t.timestamps null: false
    end
  end
end
