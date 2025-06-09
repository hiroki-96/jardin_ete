class FlowerTypesController < ApplicationController
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
end