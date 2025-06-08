class Guest < ApplicationRecord
  has_many :orders

  validates :name, presence: true
  validates :phone_number, presence: true
  # email は任意なのでバリデーションなし
end