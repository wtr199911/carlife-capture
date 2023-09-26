# Carlife Capture

<img width="1680" alt="Carlife Capture top" src="https://github.com/wtr199911/carlife-capture/assets/135807325/f43656f8-e2f8-4a06-a3ca-feb48b8f5127">


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
<img width="1069" alt="Carlife-Capture ER図" src="https://github.com/wtr199911/carlife-capture/assets/135807325/ccb2d44e-6701-4844-a78d-c239d748d5d8">

### ワイヤーフレーム
https://app.diagrams.net/#G1DJ9z7d5ypm_uPVFzWBAv4AUUzXf1SvfA#%7B%22pageId%22%3A%22tFomftPzgDyUvdMJbXfl%22%7D

### 画面遷移図

- 管理者側
<img width="729" alt="Carlife-Capture　画面遷移図（管理者側）" src="https://github.com/wtr199911/carlife-capture/assets/135807325/916aaf1d-76ba-4b93-9d60-017acda444b3">

- 会員側
<img width="1046" alt="Carlife-Capture　画面遷移図（会員側）" src="https://github.com/wtr199911/carlife-capture/assets/135807325/bfa87114-bc73-4465-858a-f92a16306678">

### テーブル定義書
https://docs.google.com/spreadsheets/d/18_-kBj2UU4riZohXxwQG5YgbN1PUKjnKqeBxAAv-2NU/edit#gid=1285004865

### アプリケーション詳細設計書
<img width="570" alt="carlife-capture アプリケーション詳細設計書" src="https://github.com/wtr199911/carlife-capture/assets/135807325/840966dd-0786-4288-a956-88fb50ed3e26">

## Gem一覧
<img width="318" alt="carlife-capture-gem" src="https://github.com/wtr199911/carlife-capture/assets/135807325/73a5de05-a547-4ad2-b127-9175398ae781">


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