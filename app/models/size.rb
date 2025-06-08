class Size < ApplicationRecord
  belongs_to :flower_type
  has_many :orders

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end