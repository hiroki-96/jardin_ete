class CreateFlowerTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :flower_types do |t|
      t.string :name, null: false             # 花の種類（例：花束、アレンジメントなど）

      t.timestamps
    end
  end
end