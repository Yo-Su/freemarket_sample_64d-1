<img src="https://user-images.githubusercontent.com/57243991/72206796-69725380-34d5-11ea-8fc9-ad78354a4d5a.jpg" width=900px>

<h1 align="center">「メルカリ」クローンアプリ</h1>

<p align="center">
<a href="https://www.ruby-lang.org/ja/"><img src="https://user-images.githubusercontent.com/39142850/71774533-1ddf1780-2fb4-11ea-8560-753bed352838.png" width="70px;" /></a>　
<a href="https://rubyonrails.org/"><img src="https://user-images.githubusercontent.com/39142850/71774548-731b2900-2fb4-11ea-99ba-565546c5acb4.png" height="60px;" /></a>　
<a href="http://haml.info/"><img src="https://user-images.githubusercontent.com/39142850/71774618-b32edb80-2fb5-11ea-9050-d5929a49e9a5.png" height="60px;" /></a>　
<a href="https://sass-lang.com/"><img src="https://user-images.githubusercontent.com/39142850/71774644-115bbe80-2fb6-11ea-822c-568eabde5228.png" height="60px" /></a><br>
<a href="https://jquery.com/"><img src="https://user-images.githubusercontent.com/39142850/71774768-d064a980-2fb7-11ea-88ad-4562c59470ae.png" height="65px;" /></a>　
<a href="https://www.mysql.com/jp/"><img src="https://user-images.githubusercontent.com/57243991/71816088-d98f6c80-30c4-11ea-82ee-f6b2892df607.png" height="60px;" /></a>　
<a href="https://aws.amazon.com/"><img src="https://user-images.githubusercontent.com/39142850/71774786-37825e00-2fb8-11ea-8b90-bd652a58f1ad.png" height="60px;" /></a>
</p>
<br>

<h3 align="center">- Contributors -</h3>
<p align="center">
<a href="https://github.com/kodaikodai"><img src="https://avatars3.githubusercontent.com/u/57389471?s=460&v=4" height="60px;" /></a>　
<a href="https://github.com/Yo-Su"><img src="https://avatars1.githubusercontent.com/u/57243991?s=460&v=4" height="60px;" /></a>　
<a href="https://github.com/natsuki-tacica"><img src="https://avatars2.githubusercontent.com/u/57396188?s=460&v=4" height="60px;" /></a>　
<a href="https://github.com/wakuwakukatsu"><img src="https://avatars3.githubusercontent.com/u/57382328?s=460&v=4" height="60px" /></a>　
<a href="https://github.com/tsuchida031025"><img src="https://avatars3.githubusercontent.com/u/56988875?s=460&v=4" height="60px;" /></a>
</p>
<br>


# 📝 このアプリについて
プログラミングスクールTECH::EXPERTの課題で作成したアプリです。
5人チームのアジャイル開発を行いました。
<br>


# 📊 データベース設計

<img src="https://user-images.githubusercontent.com/57243991/72207076-60cf4c80-34d8-11ea-8f4a-89f1f6770368.png" width=900px>

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
|type|string|null: false|
|date|date|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|post_number|integer|null: false|
|prefecture|string|null: false|
|municipality|string|null: false|
|block|string|null: false|
|building|string|
|phone_number|integer|
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
|name|string|null: false|
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
|transfer_fee|string|null: false|
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