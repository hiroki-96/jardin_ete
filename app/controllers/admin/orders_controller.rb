class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :update_status]

  def index
    @status = params[:status] || "all"
    @orders = Order.includes(:guest)
                  .order(receive_date: :asc)

    case @status
    when "未対応"
      @orders = @orders.where(status: :pending)
    when "対応中"
      @orders = @orders.where(status: :in_progress)
    when "対応済"
      @orders = @orders.where(status: :completed)
    end
  end

  def show
  end

  def destroy
    @order.destroy
    redirect_to admin_orders_path, notice: "注文を削除しました"
  end

  def update_status
    status_map = {
      "未対応" => :pending,
      "対応中" => :in_progress,
      "対応済" => :completed
    }
    
    if @order.update(status: status_map[params[:status]])
      redirect_to admin_order_path(@order), notice: "ステータスを更新しました"
    else
      redirect_to admin_order_path(@order), alert: "ステータスの更新に失敗しました"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end 