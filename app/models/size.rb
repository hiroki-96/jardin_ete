class Size < ApplicationRecord
  belongs_to :flower_type
  has_one_attached :image
  has_many :orders, dependent: :restrict_with_error

  # バリデーション：価格と画像は必須
  validates :price,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :image,
            presence: true

  # 価格が安い順に並び替える
  scope :ordered, -> { order(:price) }
end