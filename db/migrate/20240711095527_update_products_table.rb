class UpdateProductsTable < ActiveRecord::Migration[7.1]
  def change
    # Rename a column
    rename_column :products, :suppilier_name, :supplier_name

    # Add new columns
    add_column :products, :profit_percentage, :decimal
    add_column :products, :gst_percentage, :interger

  end
end
