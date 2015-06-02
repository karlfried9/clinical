class AddBillingToToClinicalTrial < ActiveRecord::Migration
  def change
    add_column :clinical_trials, :billing_to, :string
  end
end
