class FlowerType < ApplicationRecord
  has_many :sizes, dependent: :destroy
  accepts_nested_attributes_for :sizes, allow_destroy: true

  has_one_attached :image

  validates :name, presence: true
  validates :image, presence: true

  validate :at_least_one_valid_size

  private

  def at_least_one_valid_size
    valid_sizes = sizes.reject do |size|
      size.marked_for_destruction? || (size.name.blank? && size.price.blank?)
    end

    if valid_sizes.empty?
      errors.add(:base, "サイズは最低1つ以上入力してください（サイズ名と価格）")
    end
  end
end