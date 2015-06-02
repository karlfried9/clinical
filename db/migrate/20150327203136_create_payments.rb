class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :invoice_id
      t.decimal :amount
      t.string :currency_code

      t.timestamps null: false
    end
  end
end
