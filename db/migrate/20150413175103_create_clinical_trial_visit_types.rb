class CreateClinicalTrialVisitTypes < ActiveRecord::Migration
  def change
    create_table :clinical_trial_visit_types do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
