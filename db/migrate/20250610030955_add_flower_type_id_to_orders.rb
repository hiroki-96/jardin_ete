class AddFlowerTypeIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :flower_type_id, :integer
  end
end
