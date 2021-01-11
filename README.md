# Tomallo （宿泊施設共有サイト）
<br>
自身の不動産を宿として誰でも貸し出せる・好みの宿を探して泊まれるプラットフォームサイトです。
<br>
<br>
<img width="1437" alt="スクリーンショット 2021-01-04 12 35 55" src="https://user-images.githubusercontent.com/71772150/103499505-a7594c00-4e8b-11eb-9205-57cb59de7aa5.png">


下記ページで公開しております。

<https://tomallo.herokuapp.com/>

# アプリ概要
全国の物件からお好みのお部屋を簡単に予約できます。

ホスト：ご所有の不動産を掲載することで、民泊施設として有効活用できます。

ゲスト：全国どこでもいきたいところにあるお部屋を探して予約できます。

# 洗い出した用件

| 機能             | 目的                              | 詳細                             |ユースケース                                           |
| --------------- | -------------------------------   | ------------------------------- | --------------------------------------------------- |
| 物件掲載機能      | お部屋情報を公開       | 必要事項を入力したら登録できる       |写真・概要・ロケーション・料金など|
| SNS認証          | ユーザーアカウント登録方法をふやす     | SNSアカウントによるログイン機能の追加 | メールアドレス登録/googleアカウント/facebookアカウントの3つから選べる|
| 物件検索機能      | 検索機能を設けて見た目をすっきりさせる  | 都道府県・市区町村・物件種別からから物件を探す |市区町村名を入力検索欄で検索、都道府県、物件種別をボタンで選択|
| 物件編集/削除機能  | 新しい情報や古い情報を編集・削除する    | 編集・削除それぞれ遷移する          | ログインユーザーには編集or削除ボタンが表示される|
| レビュー機能      | hostへのレビューを表示する            | 詳細ページ内でレビュー機能を実装      | ログインユーザーのみコメントできる/ログインしなくてもコメントは読める|
| メッセージ機能　|ホストとゲストの連絡　|具体的なチェックイン時間や方法、要望、注意事項などのやりとりをする |　予約完了後に物件詳細ページ内においてメッセージ機能が使える|
|予約機能|　宿の確保|　カレンダーと連動して予約日を選べる|　ホストは予約可能日を指定できる　|
| 決済機能| 料金の支払い　|　PAY.JPを用いたクレジット決済　|　予約時にクレジットカードで決済・決済確認が取れて初めて予約完了となる|

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
| last_name_kana | string     | null: false |
| birthday   | date       | null: false|

### Association
- has_many :restaurants
- has_many :reservations
- has_many :payments

## houses テーブル
| Column           | Type      | Options     |
| ---------------  | --------- | ----------- |
| title            | string    | null: false |
| description      | text      | null:false  | 
| locatoin         | text      | null:false  |
| checkout         | string    | null:false  |
| checkin          | string    | null:false  |
| house_category_id | integer   | null:false  |
| room_type_id     | integer   | null:false  |
| price            | integer    | null:false  |
| postal_code      |  string    | default: "" | null: false |
| prefecture_id    | integer    | null: false |
| city,            |  sring     | default: "" |  null: false|
| house_number     | string     | default: "" | null: false|
| building_name    | string     | default: "" |
| user             | references | null:false, foreign_key: true|

### Association
- belongs_to :user
- has_many :reservations
- has_many :payments


## reservations テーブル
| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| house        | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |
| start_date   | integer     | null: false |
| end_date     | integer     | null: false |
| price        | string      | null: false |
| total        | string      | null: false |

### Association
- belongs_to :user
- belongs_to :house
- has_one :payment

## paymentsテーブル
| Column         | Type       | Options     |
|--------------- | ---------  | ----------  |
| user           | references | null: false, foreign_key: true |
| house          | references | null: false, foreign_key: true |

#### Association
- belongs_to :house
- belongs_to :reservation
- belongs_to :user

#　使い方
### ユーザー登録
1. 新規登録ボタンより登録画面へ
2. メール登録/google登録/facebook登録/のいずれかを選択
3. メール登録の場合は、必須事項を入力し登録ボタンを押す。　sns登録の場合は必須事項の入力手間なし。
### ホスト
1. マイページの物件掲載ボタンから掲載画面へ
2. 写真・概要・ロケーション・時間・料金などの必要事項を入力し登録
3. 物件詳細ページもしくはマイページの自己掲載物件一覧から、編集/削除が可能
### ゲスト
1. エリア検索フォームや都道府県・物件種別ボタンから検索
2.　物件詳細ページから予約可能状況を確認
3.　予約日を指定し、決済と予約をする

# 追加予定機能
