class CreateTrialSponsors < ActiveRecord::Migration
  def change
    create_table :trial_sponsors do |t|
      t.string :name
      t.text :contact_info

      t.timestamps null: false
    end
  end
end
