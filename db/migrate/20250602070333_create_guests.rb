class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :name,         null: false
      t.string :phone_number, null: false
      t.string :email

      t.timestamps
    end
  end
end
