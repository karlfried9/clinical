class AddDateoptionToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :dateoption, :string
  end
end
