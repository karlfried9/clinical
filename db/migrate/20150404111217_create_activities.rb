class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :organization_id
      t.string :name
      t.integer :type_id
      #t.string :category
      t.boolean :billable
      t.decimal :amount
      t.string :code_type
      t.string :code
      t.string :currency_code
      t.string :description
      t.timestamps null: false
    end
  end
end
