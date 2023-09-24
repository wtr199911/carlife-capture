# Carlife Capture

## サイト概要
### サイトテーマ
車好きの写真映えスポットを投稿・共有出来るコミュニティサイト

### テーマを選んだ理由
もともと車が好きで、ドライブなどを楽しんでいるのですが、車が映えるフォトスポットを探すのにすごく時間がかかっていました。<br>
その為自身がドライブで知ったフォトスポットを共有したり、写真を投稿出来るサイトがほしいと思い、このテーマにしました。

### ターゲットユーザ
- ドライブが好き、車好きな人
- 車映えスポットがどこか悩んでいる人

### 主な利用シーン
- ドライブ時に映えスポットを探したい時
- 自分が撮った写真を共有したい時

## 主な使用言語
- HTML
- CSS
- SCSS
- Ruby
- JavaScript
- フレームワーク
    - Ruby on Rails

## 使用方法

```bash
$ git clone git@github.com:wtr199911/carlife-capture.git
$ cd carlife-capture
$ bundle install
$ rails db:migrate
$ rails db:seed
$ yarn add @babel/plugin-proposal-private-methods @babel/plugin-proposal-private-property-in-object
$ rails s
```

#### 管理者用アカウント

* **メールアドレス**:
admin@email.com

* **パスワード**:
adminpass

* **管理者用ログインURL**:
/admin/sign_in

#####  顧客側の操作は顧客用のサインアップが必要となります。

* **顧客用サインアップURL**:
/customers/sign_up


## 設計書

### ER図

### テーブル定義書

### アプリケーション詳細設計書

## Gem一覧

## 開発環境

- Railsバージョン : 6.1.7.4

- Rubyバージョン : 3.1.2

- データベース : SQLite3

- OS : Linux

## 使用素材

- ロゴ作成
  flaticon  https://www.flaticon.com/free-icons/gps

- その他画像
  unsplash  https://unsplash.com/ja

- アイコン
  fontawesome  https://fontawesome.com