class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :guest,       null: false, foreign_key: true  # ゲスト情報と関連
      t.references :size,        null: false, foreign_key: true  # 選ばれたサイズ（花種も含まれる）

      t.integer    :usage,       null: false                     # 用途（enum予定）
      t.integer    :color,       null: false                     # 色味（enum予定）
      t.integer    :atmosphere,  null: false                     # 雰囲気（enum予定）

      t.text       :memo                                            # 備考欄（任意）
      t.integer    :receive_method, null: false                  # 受け取り方法（店頭 or 配達）

      t.date       :receive_date, null: false                    # 希望日（受取 or 配達）
      t.time       :receive_time, null: false                    # 希望時間

      t.string     :delivery_address                             # 配達希望住所（配達時のみ）
      t.string     :delivery_name                                # 配達先名前（配達時のみ）

      t.timestamps
    end
  end
end