class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :uuid
      t.decimal :sales_price, precision: 10, scale: 2
      t.decimal :purchase_price, precision: 10, scale: 2
      t.text :suppilier_name
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
