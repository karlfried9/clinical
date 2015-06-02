class CreateClinicalTrialAttachments < ActiveRecord::Migration
  def change
    create_table :clinical_trial_attachments do |t|
      t.integer :clinical_trial_id

      t.timestamps null: false
    end
  end
end
