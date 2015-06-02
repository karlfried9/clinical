class CreatePatientVisitSchedules < ActiveRecord::Migration
  def change
    create_table :patient_visit_schedules do |t|
      t.integer :patient_id
      t.integer :clinical_trial_visit_id
      t.date :schedule_date

      t.timestamps null: false
    end
  end
end
