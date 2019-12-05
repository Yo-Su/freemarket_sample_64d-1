# データベース設計


## userテーブル
|Column|Type|Options|
|------|----|-------|
|nick_name|string|null: false|unique: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|password|string|null: false|
|mail_address|string|null: false|unique: true|
|phone_number|integer|null: false|unique: true|
### Association
- has_many :cashflows,dependent: :destroy
- has_many  :addresses,dependent: :destroy
- has_many  :credit_card_infos,dependent: :destroy
- has_many  :messages,dependent: :destroy
- has_many  :items,dependent: :destroy
- has_many  :likes,dependent: :destroy

## cashflowテーブル
|Column|Type|Options|
|------|----|-------|
|amount|integer|null: false|
|point|integer|null: false|
|cashflow_type|string|null: false|
|cashflow_date|date|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|post_number|integer|null: false|
|address_prefecture|string|null: false|
|address_municipality|string|null: false|
|address_block|string|null: false|
|address_building|string|
|address_phone|integer|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## credit_card_infoテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|pin_number|integer|null: false|
|expiration_date|date|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## messageテーブル
|Column|Type|Options|
|------|----|-------|
|message|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## imageテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item

## brandテーブル
|Column|Type|Options|
|------|----|-------|
|brand_name|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- has_many  :items


## likeテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user


## itemテーブル
|Column|Type|Options|
|------|----|-------|
|status|string|null: false|
|name|string|null: false|
|from_delivery_area|string|null: false|
|to_delivery_area|string|null: false|
|price|integer|null: false|
|delivery_date|date|null: false|
|size|string|null: false|
|grade|string|null: false|
|transfer_fee|integer|null: false|
|delivery_type|string|null: false|
|describe|string|null: false|
|buyer_id|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
### Association
- has_many  :images,dependent: :destroy
- has_many  :messages,dependent: :destroy
- has_many  :likes,dependent: :destroy
- belongs_to :user
- belongs_to :brand
- belongs_to :category

## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many  :items
- has_ancestry


