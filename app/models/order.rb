class Order < ApplicationRecord
  belongs_to :guest
  belongs_to :size

  validates :usage, presence: true
  validates :color, presence: true
  validates :atmosphere, presence: true
  validates :receive_method, presence: true
  validates :receive_date, presence: true
  validates :receive_time, presence: true

  # 配達の場合のみバリデーション（コントローラー側で条件分岐して追加してもOK）
  with_options if: :delivery? do
    validates :delivery_address, presence: true
    validates :delivery_name, presence: true
  end

  def delivery?
    receive_method == 1 # 例：ActiveHashかenumでdelivery: 1 を想定
  end

  has_one_attached :reference_image
end