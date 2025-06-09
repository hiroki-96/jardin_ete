class Size < ApplicationRecord
  belongs_to :flower_type
  has_one_attached :image
  has_many :orders, dependent: :restrict_with_error

  # どちらかが入力されていたらバリデーションを行う
  with_options if: -> { name.present? || price.present? } do
    validates :name,
              presence: true,
              uniqueness: { scope: :flower_type_id },
              format: { with: /\A[A-Z]+\z/, message: "は半角大文字アルファベットで入力してください" }

    validates :price,
              presence: true,
              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end

  # S → M → L → LL → XL...の順に並べる
  scope :ordered, -> {
    order(Arel.sql(<<~SQL.squish))
      CASE name
        WHEN 'S' THEN 1
        WHEN 'M' THEN 2
        WHEN 'L' THEN 3
        WHEN 'LL' THEN 4
        WHEN 'XL' THEN 5
        ELSE 6
      END
    SQL
  }
end