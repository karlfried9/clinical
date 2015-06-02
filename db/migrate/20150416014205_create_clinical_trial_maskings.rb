class CreateClinicalTrialMaskings < ActiveRecord::Migration
  def change
    create_table :clinical_trial_maskings do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
