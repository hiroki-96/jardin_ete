class OrdersController < ApplicationController
  def new
    @order = Order.new
    @flower_types = FlowerType.all
  end

  def create
  end

  private

  def order_params
    params.require(:order).permit(
      :guest_id,
      :size_id,
      :usage_id,
      :color_tone_id,
      :mood_id,
      :reference_image,
      :memo
    )
  end

end
