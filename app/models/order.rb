class Order < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :guest
  belongs_to :size

  belongs_to_active_hash :usage
  belongs_to_active_hash :color_tone
  belongs_to_active_hash :mood

  has_one_attached :reference_image

  # ActiveHash項目のバリデーション（id: 1 は '---'）
  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :usage_id
    validates :color_tone_id
    validates :mood_id
  end

  # その他必須項目
  validates :receive_method, :receive_date, :receive_time, presence: true

  # 配送時のバリデーション
  with_options if: :delivery? do
    validates :delivery_address, presence: true
    validates :delivery_name, presence: true
  end

  def delivery?
    receive_method == 1 # enumやActiveHashの値に対応
  end
end