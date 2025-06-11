class Admin::FlowerTypesController < ApplicationController
  before_action :set_flower_type, only: [:show, :edit, :update, :destroy]

  def index
    @flower_types = FlowerType.all
  end

  def show
  end

  def new
    @flower_type = FlowerType.new
    @flower_type.sizes.build
  end

  def create
    @flower_type = FlowerType.new(flower_type_params)
    if @flower_type.save
      # ✅ 保存できたら size 登録ページへ
      redirect_to new_admin_flower_type_size_path(@flower_type), notice: "花の種類を登録しました。次に参考画像と価格を登録してください。"
    else
      render :new
    end
  end

  def edit
    @flower_type.sizes.build if @flower_type.sizes.empty?
  end

  def update
    if @flower_type.update(flower_type_params)
      redirect_to admin_flower_type_path(@flower_type), notice: "更新が完了しました"
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
    sizes = flower_type.sizes.order(price: :asc).select { |s| s.price.present? }

    render json: sizes.map { |s|
      {
        id: s.id,
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
      sizes_attributes: [
        :id,
        :price,
        :image,
        :_destroy
      ]
    )
  end
end