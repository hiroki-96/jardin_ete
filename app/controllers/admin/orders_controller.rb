class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :update]

  def index
    @status = params[:status] || "all"
    @orders = Order.includes(:guest)
                  .order(receive_date: :asc)

    status_map = {
      "未対応" => :pending,
      "対応中" => :in_progress,
      "対応済" => :completed
    }

    if status_map[@status]
      @orders = @orders.where(status: Order.statuses[status_map[@status]])
    elsif @status == "all" || @status.blank?
      @orders = @orders.where.not(status: :completed)
    end
  end

  def show
  end

  def destroy
    @order.destroy
    redirect_to admin_orders_path, notice: "注文を削除しました"
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: 'ステータスを更新しました'
    else
      redirect_to admin_order_path(@order), alert: 'ステータスの更新に失敗しました'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end 