class CreateClinicalTrialStatuses < ActiveRecord::Migration
  def change
    create_table :clinical_trial_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
