# テーブル設計

---

## guests テーブル

| Column           | Type   | Options     |
|------------------|--------|-------------|
| name             | string | null: false |
| email            | string |             |
| phone_number     | string | null: false |
| delivery_name    | string |             |
| delivery_address | string |             |

### Association

- has_many :orders

---

## flower_types テーブル

| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association

- has_many :sizes

※ 管理画面から画像登録・編集が可能（ActiveStorage）

---

## sizes テーブル

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| flower_type_id | references | null: false, foreign_key: true |
| name           | string     | null: false                    |
| price          | integer    | null: false                    |

### Association

- belongs_to :flower_type  
- has_many :orders

※ サイズごとの画像も登録可能（ActiveStorage使用 or 別テーブル化可能）

---

## orders テーブル

| Column             | Type          | Options                        |
|--------------------|---------------|--------------------------------|
| guest_id           | references    | null: false, foreign_key: true |
| size_id            | references    | null: false, foreign_key: true |
| usage              | integer       | null: false                    |
| color              | integer       | null: false                    |
| atmosphere         | integer       | null: false                    |
| memo               | text          |                                |
| reference_image    | ActiveStorage |                                |
| receive_method     | integer       | null: false                    |
| receive_date       | date          | null: false                    |
| receive_time       | time          | null: false                    |

### Association

- belongs_to :guest  
- belongs_to :size  
- has_one_attached :reference_image

---

## 管理機能（概要）

- flower_types に対して画像を登録・編集可能（オーナーが管理画面から操作）
- サイズごとの画像も登録可能にする設計（必要なら別テーブルで管理）
- 管理者は Devise による認証を利用

---

## その他

- 用途・色味・雰囲気・受け取り方法は `ActiveHash` や `enum` で実装予定
- email、delivery_address、delivery_name は配達時のみ入力される（バリデーションで制御）
- 今後、会員登録やマイページ連携などの拡張を予定