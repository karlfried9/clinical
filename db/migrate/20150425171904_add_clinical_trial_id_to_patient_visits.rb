class AddClinicalTrialIdToPatientVisits < ActiveRecord::Migration
  def change
    add_column :patient_visits, :clinical_trial_id, :integer
  end
end
