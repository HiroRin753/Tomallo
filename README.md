










# 洗い出した用件

| 機能             | 目的                              | 詳細                             |ユースケース                                           |
| --------------- | -------------------------------   | ------------------------------- | --------------------------------------------------- |
| SNS認証          | ユーザーアカウント登録方法をふやす     | SNSアカウントによるログイン機能の追加 | 手入力/googleアカウント/facebookアカウントの3つから選べる|
| 物件検索機能      | 検索機能を設けて見た目をすっきりさせる  | 名前の検索とエリアから物件を探す      |・物件名を入力し該当物件ページへ遷移・エリアを選択し該当エリアの物件を一覧表示"|
| 物件登録機能      | 物件を登録しないと始まらない           | 必要事項を入力したら登録できる       |・物件名 ・住所 ・築年数 ・総個数 ・階数 ・物件概要|
| 物件編集/削除機能  | 新しい情報や古い情報を編集・削除する    | 編集・削除それぞれ遷移する          | ログイン時に編集・削除ボタンを表示する|
| コメント機能      | hostへのレビューを表示する            | 詳細ページ内でコメント機能を実装      | ・ログインユーザーのみコメントできる・ログインしなくてもコメントは読める|
| ユーザー管理機能   |                    | 登録・ログイン・ログアウトができる    | ・ニックネーム・メール・パスワードで登録|



# テーブル設計

## users テーブル
| Column     | Type      | Options     |
| --------   | ------    | ----------- |
| nickname   | string    | null: false |
| email      | string    | null: false |
| password   | string    | null: false |
| first_name | string    | null: false |
| last_name  | string    | null: false |
| first_name_kana | string    | null: false |
| last_name_kana| string      | null: false |

### Association
- has_many :restaurants
- has_many :comments
- has_many :reserves
- has_many :payments

## houses テーブル
| Column           | Type      | Options     |
| ---------------  | --------- | ----------- |
| name             | string    | null: false |
| description      | text      | null:false  | 
| phone_number     | string   | null:false  |
| address          | string    | null:false  |
| access           | string    | null:false  |
| genre_id         | integer   | null:false  |
| opening_hours    | string   | null:false  |
| how_to_pay       | string    | null:false  |
| user             | references | null:false, foreign_key: true|
| comments         | references | null:false, foreign_key: true|

### Association
- belongs_to :user
- has_many :comments
- has_many :reserves 
- has_many :payments

## courseテーブル
| Column           | Type      | Options     |
| ---------------  | --------- | ----------- |
| name             | string    | null: false |
| description      | text      | null:false  | 
| price            | integer   | null:false  |
| time             | integer   | null:false  |

#### Association
- belongs_to :restaurant
- has_many :reserves


## comments テーブル
| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| text         | text       | null:false                     |
| user         | references | null: false, foreign_key: true |
| restaurant   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :restaurant


## reserves テーブル
| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| restaurant   | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |
| email        | string     | null:false|
| first_name   | string     | null: false |
| last_name    | string     | null: false |
| first_name_kana | string      | null: false |
| last_name_kana  | string      | null: false |
| phone_number | string | null:false|

### Association
- belongs_to :user
- belongs_to :restaurants
- has_one :payment
- belongs_to :course

## paymentsテーブル
| Column         | Type       | Options     |
|--------------- | ---------  | ----------  |
| user           | references | null: false, foreign_key: true |
| restaurant     | references | null: false, foreign_key: true |
| reserve        | references | null: false, foreign_key: true |
| menu           | references | null: false, foreign_key: true |

#### Association
- belongs_to :restaurant
- belongs_to :reserve
- belongs_to :user
- belongs_to :menu