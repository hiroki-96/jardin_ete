class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_guest  # ゲスト情報の入力フォーム生成用
    @flower_types = FlowerType.all  # メニュー選択肢表示用
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path, notice: "ご注文が完了しました"
    else
      @flower_types = FlowerType.all
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @guest = @order.build_guest unless @order.guest
    @flower_types = FlowerType.all

    # バリデーション確認（不備があればnewに戻す）
    unless @order.valid?
      Rails.logger.debug(@order.errors.full_messages) # ログ出力
      flash.now[:alert] = @order.errors.full_messages.join("<br>").html_safe # ビュー用
      return render :new
    end
  end

  private

  # Strong Parameters（フォームで許可する項目）
  def order_params
    params.require(:order).permit(
      :flower_type_id,     # メニュー
      :size_id,            # サイズ
      :usage_id,           # 用途
      :color_tone_id,      # 色味
      :mood_id,            # 雰囲気
      :reference_image,    # 参考画像
      :memo,               # 備考
      :receive_method,     # 受け取り方法（enum）
      :receive_date,       # 希望日
      :receive_time,       # 希望時間
      :delivery_address,   # 配達先住所（配達時のみ）
      :delivery_name,      # 配達先名前（配達時のみ）
      guest_attributes: [  # ゲスト情報（ネスト）
        :name,
        :phone_number,
        :email
      ]
    )
  end
end