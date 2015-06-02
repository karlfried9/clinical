class CreatePatientAssignedVisits < ActiveRecord::Migration
  def change
    create_table :patient_assigned_visits do |t|
      t.integer :patient_id
      t.integer :clinical_trial_visit_id
      t.timestamps null: false
    end
  end
end
