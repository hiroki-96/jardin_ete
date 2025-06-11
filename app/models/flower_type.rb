class FlowerType < ApplicationRecord
  has_many :sizes, dependent: :destroy
  accepts_nested_attributes_for :sizes, allow_destroy: true

  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true

  validate :at_least_one_valid_size, if: -> { sizes.any? }
  validate :max_five_sizes_limit, if: -> { sizes.any? }

  private

  # 少なくとも1件の価格と画像のセットが必要
  def at_least_one_valid_size
    valid_sizes = sizes.reject do |size|
      size.marked_for_destruction? || (size.price.blank? && !size.image.attached?)
    end

    if valid_sizes.empty?
      errors.add(:base, "参考画像と価格を1件以上入力してください")
    end
  end

  # 有効なサイズが5件を超える場合はエラー
  def max_five_sizes_limit
    valid_sizes = sizes.reject(&:marked_for_destruction?)
    if valid_sizes.size > 5
      errors.add(:base, "参考画像と価格は最大5件までしか登録できません")
    end
  end
end