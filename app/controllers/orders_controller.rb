class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_guest  # ゲスト情報の入力フォーム生成用
    @flower_types = FlowerType.all
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

  private

  def order_params
    params.require(:order).permit(
      :size_id,
      :usage_id,
      :color_tone_id,
      :mood_id,
      :reference_image,
      :memo,
      :receive_method,
      :receive_date,
      :receive_time,
      :delivery_address,
      :delivery_name,
      guest_attributes: [:name, :phone_number, :email]
    )
  end
end