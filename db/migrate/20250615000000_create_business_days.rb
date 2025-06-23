class CreateBusinessDays < ActiveRecord::Migration[7.1]
  def change
    create_table :business_days do |t|
      t.date :date, null: false
      t.time :opening_time, null: false
      t.time :closing_time, null: false
      t.boolean :is_open, null: false, default: true

      t.timestamps
    end
    add_index :business_days, :date, unique: true
  end
end 