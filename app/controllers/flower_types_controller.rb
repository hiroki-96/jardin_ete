class FlowerTypesController < ApplicationController
  skip_before_action :authenticate_admin!

  def sizes
    flower_type = FlowerType.find(params[:id])
    sizes = flower_type.sizes.ordered.select { |s| s.price.present? } # ← OK
    render json: sizes.map { |s|
      {
        id: s.id,
        price: s.price,
        image_url: s.image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(s.image, only_path: true) : nil
      }
    }
  end
end