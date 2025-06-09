class Admin::SizesController < ApplicationController
  before_action :set_flower_type
  before_action :set_size, only: [:edit, :update, :destroy]

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

  def size_params
    params.require(:size).permit(:name, :price, :image)
  end
end