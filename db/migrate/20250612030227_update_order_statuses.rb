class UpdateOrderStatuses < ActiveRecord::Migration[7.1]
  def up
    # 既存の注文データのステータスをpending（未対応）に設定
    Order.where(status: nil).update_all(status: :pending)
  end

  def down
    # ロールバック時の処理は不要
  end
end
