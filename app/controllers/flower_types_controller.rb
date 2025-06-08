class FlowerTypesController < ApplicationController
  before_action :set_flower_type, only: [:edit, :update, :destroy]

  def new
    @flower_type = FlowerType.new
  end

  def create
    @flower_type = FlowerType.new(flower_type_params)
    if @flower_type.save
      redirect_to new_flower_type_path, notice: "登録が完了しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @flower_type.update(flower_type_params)
      redirect_to edit_flower_type_path(@flower_type), notice: "更新が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @flower_type.destroy
    redirect_to new_flower_type_path, notice: "削除が完了しました"
  end

  private

  def set_flower_type
    @flower_type = FlowerType.find(params[:id])
  end

  def flower_type_params
    params.require(:flower_type).permit(:name, :image)
  end
end