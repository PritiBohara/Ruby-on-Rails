class UpdateProductsTable < ActiveRecord::Migration[7.1]
  def change
    # Rename a column
    rename_column :products, :suppilier_name, :supplier_name

    # Add new columns
    add_column :products, :profit_percentage, :decimal
    add_column :products, :gst_percentage, :interger

    # If you need to add columns with default values or constraints, you can do so like this:
    # add_column :products, :new_column1, :string, default: 'default_value'
    # add_column :products, :new_column2, :integer, null: false, default: 0
  end
end
