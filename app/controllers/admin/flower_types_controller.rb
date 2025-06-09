class Admin::FlowerTypesController < ApplicationController
  before_action :set_flower_type, only: [:show, :edit, :update, :destroy]

  def index
    @flower_types = FlowerType.all
  end

  def show
  end

  def new
    @flower_type = FlowerType.new
    @flower_type.sizes.build # S/M/Lの空フォームを表示
  end

  def create
    @flower_type = FlowerType.new(flower_type_params)
    if @flower_type.save
      redirect_to new_admin_flower_type_path, notice: "登録が完了しました" # 修正
    else
      render :new
    end
  end

  def edit
    3.times { @flower_type.sizes.build } if @flower_type.sizes.empty? # 編集時にも3枠用意
  end

  def update
    if @flower_type.update(flower_type_params)
      redirect_to edit_admin_flower_type_path(@flower_type), notice: "更新が完了しました" # 修正
    else
      render :edit
    end
  end

  def destroy
    @flower_type.destroy
    redirect_to admin_flower_types_path, notice: '花のメニューを削除しました'
  end

  # JSONでサイズ情報（JSで利用）
  def sizes
    flower_type = FlowerType.find(params[:id])
    sizes = flower_type.sizes.ordered.select { |s| s.name.present? && s.price.present? }

    render json: sizes.map { |s|
      {
        id: s.id,
        name: s.name,
        price: s.price,
        image_url: s.image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(s.image, only_path: true) : nil
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