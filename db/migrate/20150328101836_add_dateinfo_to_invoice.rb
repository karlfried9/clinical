class AddDateinfoToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :fromdate, :date
    add_column :invoices, :todate, :date
  end
end
