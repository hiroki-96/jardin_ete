class FlowerType < ApplicationRecord
  has_many :sizes, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
end