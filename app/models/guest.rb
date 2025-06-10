class Guest < ApplicationRecord
  belongs_to :order

  validates :name, presence: true
  validates :phone_number, presence: true
  # email は任意なのでバリデーションなし
end