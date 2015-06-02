class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :salutation
      t.string :first_name
      t.string :last_name
      t.string :patient_id
      t.date :date_of_birth
      t.text :notes
      t.integer :clinical_trial_id
      t.integer :arm_id
      t.timestamps null: false
    end
  end
end
