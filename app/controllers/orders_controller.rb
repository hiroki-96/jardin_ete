class OrdersController < ApplicationController
  def new
    @order = Order.new
    @flower_types = FlowerType.all
  end

  def create
  end

end
