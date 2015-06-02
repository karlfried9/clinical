class CreateStudyStatuses < ActiveRecord::Migration
  def change
    create_table :study_statuses do |t|
      t.string :code
      t.string :name
      t.timestamps null: false
    end
  end
end
