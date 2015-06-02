class AddClinicalTrialIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :clinical_trial_id, :integer
  end
end
