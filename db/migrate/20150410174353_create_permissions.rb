class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      #t.references :asset, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
