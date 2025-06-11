class ChangeSizeIdToNullableInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_null :orders, :size_id, true
  end
end