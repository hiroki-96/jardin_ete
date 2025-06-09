class FlowerTypesController < ApplicationController
  before_action :set_flower_type, only: [:edit, :update, :destroy]

  def new
    @flower_type = FlowerType.new
    3.times { @flower_type.sizes.build } # S/M/Lの空フォームを表示
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
    3.times { @flower_type.sizes.build } if @flower_type.sizes.empty? # 編集時にも3枠用意
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

  # JSONでサイズ情報（JSで利用）
  def sizes
    flower_type = FlowerType.find(params[:id])
    render json: flower_type.sizes.map { |s|
      {
        id: s.id,
        name: s.name,
        price: s.price,
        image_url: s.image.attached? ? url_for(s.image) : nil
      }
    }
  end

  private

  def set_flower_type
    @flower_type = FlowerType.find(params[:id])
  end

  def flower_type_params
    params.require(:flower_type).permit(
      :name,
      :image,
      sizes_attributes: [:id, :name, :price, :image, :_destroy]
    )
  end
end