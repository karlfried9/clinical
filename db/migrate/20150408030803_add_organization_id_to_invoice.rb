class AddOrganizationIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :organization_id, :integer
  end
end
