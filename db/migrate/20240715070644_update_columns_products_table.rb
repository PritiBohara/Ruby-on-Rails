class UpdateColumnsProductsTable < ActiveRecord::Migration[7.1]
  def change

     # Add new columns
     add_column :products, :base_price, :decimal
     add_column :products, :is_inclusive, :boolean
     add_column :products, :purchaes_unit, :string
     add_column :products, :sales_unit, :string
  
  end
end
