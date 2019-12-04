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
### Association
- has_many :cashflows
- has_many :phoneNumbers
- has_many  :addresses
- has_many  :creditCardInfos
- has_many  :messages
- has_many  :items
- has_many  :mailAddresses


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

## phoneNumberテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|unique: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|address1|string|null: false|
|address2|string|null: false|
|address3|string|null: false|
|address4|string|null: false|
|post_number|integer|null: false|
|address_phone|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## creditCardInfoテーブル
|Column|Type|Options|
|------|----|-------|
|cardNumber|integer|null: false|
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
- belongs_to :item

## categoryMiniテーブル
|Column|Type|Options|
|------|----|-------|
|category_name|string|null: false|
|category_group|string|null: false|
### Association
- has_many  :items
- belongs_to :categoryMiddles


## categoryMiddleテーブル
|Column|Type|Options|
|------|----|-------|
|category_name|string|null: false|
|category_group|string|null: false|
### Association
- has_many  :categoryMinis
- belongs_to :categoryBig
- has_many  :items

## categoryBigテーブル
|Column|Type|Options|
|------|----|-------|
|category_name|string|null: false|
### Association
- has_many  :items
- has_many  :categoryMiddles


## likeテーブル
|Column|Type|Options|
|------|----|-------|
|count|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- has_many  :items
- has_many  :categoryMiddles


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
|categoryBig_id|integer|null: false, foreign_key: true|
|categoryMiddle_id|integer|null: false, foreign_key: true|
|categoryMini_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
### Association
- has_many  :images
- has_many  :messages
- belongs_to :user
- belongs_to :brand
- belongs_to :categoryBig
- belongs_to :categoryMiddle
- belongs_to :categoryMini

## mailAddressテーブル
|Column|Type|Options|
|------|----|-------|
|mail_address|string|null: false|unique: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user


<img width="1057" alt="スクリーンショット 2019-12-04 16 47 22" src="https://user-images.githubusercontent.com/57389471/70134729-fbfc2780-16cb-11ea-9ab9-b7e51b998430.png">
