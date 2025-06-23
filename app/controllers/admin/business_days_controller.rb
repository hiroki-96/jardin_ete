class Admin::BusinessDaysController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_business_day, only: [:edit, :update, :destroy]

  def index
    @business_days = BusinessDay.order(:date)
    @business_day = BusinessDay.new

    respond_to do |format|
      format.html
      format.json {
        render json: @business_days.map { |d|
          {
            id: d.id,
            date: d.date.to_s,
            is_open: d.is_open,
            opening_time: d.opening_time.strftime('%H:%M'),
            closing_time: d.closing_time.strftime('%H:%M')
          }
        }
      }
    end
  end

  def new
    @business_day = BusinessDay.new
  end

  def create
    @business_day = BusinessDay.new(business_day_params)
    if @business_day.save
      redirect_to admin_business_days_path, notice: '営業日を登録しました'
    else
      @business_days = BusinessDay.order(:date)
      render :index
    end
  end

  def edit
  end

  def update
    if @business_day.update(business_day_params)
      redirect_to admin_business_days_path, notice: '営業日を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @business_day.destroy
    redirect_to admin_business_days_path, notice: '営業日を削除しました'
  end

  # 日付指定で休業にする
  def set_closed_by_date
    day = BusinessDay.find_by(date: params[:date])
    if day
      day.update(is_open: false)
      render json: { status: 'ok', message: '休業にしました' }
    else
      # レコードがなければ新規で休業レコードを作成
      BusinessDay.create(date: params[:date], is_open: false, opening_time: '00:00', closing_time: '00:00')
      render json: { status: 'ok', message: '休業にしました（新規）' }
    end
  end

  private

  def set_business_day
    @business_day = BusinessDay.find(params[:id])
  end

  def business_day_params
    params.require(:business_day).permit(:date, :opening_time, :closing_time, :is_open)
  end
end 