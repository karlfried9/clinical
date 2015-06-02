class CreateDiseaseStages < ActiveRecord::Migration
  def change
    create_table :disease_stages do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
