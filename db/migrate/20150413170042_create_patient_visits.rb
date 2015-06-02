class CreatePatientVisits < ActiveRecord::Migration
  def change
    create_table :patient_visits do |t|
      t.integer :clinical_trial_visit_id
      t.integer :patient_id
      t.string :description
      t.date :recorded_date
      t.timestamps null: false
    end
  end
end
