class Admin::SizesController < ApplicationController
  before_action :set_flower_type
  before_action :set_size, only: [:edit, :update, :destroy]

  def new
    @existing_size_count = @flower_type.sizes.count
  end

  def create
    if @flower_type.update(flower_type_params)
      redirect_to admin_flower_type_path(@flower_type), notice: "参考価格と画像を追加しました"
    else
      @existing_size_count = @flower_type.sizes.count
      render :new
    end
  end

  def edit; end

  def update
    if @size.update(size_params)
      redirect_to admin_flower_type_path(@flower_type), notice: "サイズ情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @size.destroy
    redirect_to admin_flower_type_path(@flower_type), notice: "サイズを削除しました"
  end

  private

  def set_flower_type
    @flower_type = FlowerType.find(params[:flower_type_id])
  end

  def set_size
    @size = @flower_type.sizes.find(params[:id])
  end

  def flower_type_params
    params.require(:flower_type).permit(
      sizes_attributes: [:price, :image]
    )
  end

  def size_params
    params.require(:size).permit(:price, :image)
  end
end