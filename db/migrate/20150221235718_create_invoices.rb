class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :patient
      t.text :description
      t.string :status
      t.date :created_date
      t.text :mailing_address
      t.text :notes

      t.timestamps null: false
    end
  end
end
