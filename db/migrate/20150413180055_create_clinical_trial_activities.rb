class CreateClinicalTrialActivities < ActiveRecord::Migration
  def change
    create_table :clinical_trial_activities do |t|
      t.integer :clinical_trial_visit_id
      t.integer :activity_id
      t.boolean :performed
      t.boolean :billable
      t.integer :amount
      t.timestamps null: false
    end
  end
end
