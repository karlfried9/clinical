class CreateArms < ActiveRecord::Migration
  def change
    create_table :arms do |t|
      t.string  :name
      t.string  :description
      t.integer :clinical_trial_id
      t.timestamps null: false
    end
  end
end
