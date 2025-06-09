class CreateSizes < ActiveRecord::Migration[7.1]
  def change
    create_table :sizes do |t|
      t.references :flower_type, null: false, foreign_key: true  # どの花に属するサイズか
      t.string     :name,        null: true                      # サイズ名（S, M, L）
      t.integer    :price,       null: true                      # このサイズの価格（円）

      t.timestamps
    end
  end
end