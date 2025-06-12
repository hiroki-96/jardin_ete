class OrdersController < ApplicationController
  # 注文フォームの初期表示（新規 or 修正から戻った場合）
  def new
    @order = Order.new

    if session[:from_confirm] && session[:order_data].is_a?(Hash) && session[:guest_data].is_a?(Hash)
      @order.assign_attributes(session[:order_data])
      @order.build_guest.assign_attributes(session[:guest_data])
      session.delete(:from_confirm)
    else
      @order.build_guest
    end

    @flower_types = FlowerType.all
  end

  # 確認画面の表示
  def confirm
    @order = Order.new(order_params)
    @guest = @order.build_guest unless @order.guest
    @flower_types = FlowerType.all

    # 参考画像のsigned_idがあれば一時的にattach
    if params[:order] && params[:order][:reference_image_signed_id].present?
      @order.reference_image.attach(ActiveStorage::Blob.find_signed(params[:order][:reference_image_signed_id]))
    end

    unless @order.valid?
      Rails.logger.debug(@order.errors.full_messages)  # ログ出力
      flash.now[:alert] = @order.errors.full_messages.join("<br>").html_safe
      return render :new
    end

    # セッションに注文内容を一時保存（修正で戻ったとき用）
    session[:order_data] = @order.attributes
    session[:guest_data] = @order.guest.attributes
    session[:from_confirm] = true
  end

  # 注文確定（DBに保存）
  def create
    # セッションからデータを復元
    @order = Order.new(session[:order_data])
    @order.build_guest(session[:guest_data])

    # 参考画像のsigned_idがあればattach
    if params[:order] && params[:order][:reference_image_signed_id].present?
      @order.reference_image.attach(ActiveStorage::Blob.find_signed(params[:order][:reference_image_signed_id]))
    end

    if @order.save
      # セッション情報を削除
      session.delete(:order_data)
      session.delete(:guest_data)
      session.delete(:from_confirm)

      redirect_to thanks_orders_path, notice: "ご注文が完了しました"
    else
      @flower_types = FlowerType.all
      render :confirm
    end
  end

  def thanks
    # 完了ページの表示
  end

  private

  # Strong Parameters（許可されたパラメータのみ受け取る）
  def order_params
    params.require(:order).permit(
      :flower_type_id,
      :custom_price,
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
      guest_attributes: [
        :name,
        :phone_number,
        :email
      ]
    )
  end
end