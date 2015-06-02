class CreateClinicalTrialPhases < ActiveRecord::Migration
  def change
    create_table :clinical_trial_phases do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
