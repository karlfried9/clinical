class AddBillToEmailToClinicalTrial < ActiveRecord::Migration
  def change
    add_column :clinical_trials, :bill_to_email, :string
  end
end
