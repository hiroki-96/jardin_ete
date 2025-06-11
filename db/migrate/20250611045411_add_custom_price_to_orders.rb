class AddCustomPriceToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :custom_price, :integer
  end
end
