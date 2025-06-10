class AddOrderIdToGuests < ActiveRecord::Migration[7.1]
  def change
    add_column :guests, :order_id, :integer
  end
end
