class CreateClinicalTrialVisitFormats < ActiveRecord::Migration
  def change
    create_table :clinical_trial_visit_formats do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
