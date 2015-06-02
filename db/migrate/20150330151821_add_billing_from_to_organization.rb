class AddBillingFromToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :billing_from, :string
  end
end
