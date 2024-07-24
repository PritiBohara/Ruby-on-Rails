class UpdateColumnsProductsTableAdd < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :expiry_date, :date
  end
end
