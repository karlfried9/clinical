class CreateClinicalTrialVisits < ActiveRecord::Migration
  def change
    create_table :clinical_trial_visits do |t|

      t.integer :clinical_trial_id
      t.string :name
      t.string :description
      t.integer :type_id
      t.integer :format_id
      t.integer :offset_days
      t.integer :after_visit_id
      t.integer :tolerance_number_of_days

      t.timestamps null: false
    end
  end
end
