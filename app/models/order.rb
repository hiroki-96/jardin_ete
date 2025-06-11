class Order < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # 関連付け（ゲストは1注文に対して1人）
  has_one :guest, dependent: :destroy
  accepts_nested_attributes_for :guest

  belongs_to :flower_type

  belongs_to_active_hash :usage
  belongs_to_active_hash :color_tone
  belongs_to_active_hash :mood

  # 添付ファイル（参考画像）
  has_one_attached :reference_image

  # enum設定（店頭受け取り or 配達）
  enum receive_method: { store_pickup: 0, delivery: 1 }

  # ActiveHash項目のバリデーション（id: 1 は '---'）
  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :usage_id
    validates :color_tone_id
    validates :mood_id
  end

  # その他必須項目（時間は配達のみ）
  validates :receive_method, :receive_date, presence: true
  validates :receive_time, presence: true, if: :delivery?

  # 配送時のバリデーション（「配達」を選択したときのみ必須）
  with_options if: :delivery? do
    validates :delivery_address, presence: true
    validates :delivery_name, presence: true
  end
end