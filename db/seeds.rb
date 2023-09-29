# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者登録
Admin.create!(email: "admin@email.com", password: "adminpass")

# テストデータ

# グループ1

suvlove = Group.find_or_create_by!(name: "SUV Love") do |group|
  group.introduction = "SUV好き募集"
  group.owner_id = 1
end

# グループ2
drive = Group.find_or_create_by!(name: "CarLife") do |group|
  group.introduction = "誰でも歓迎！！"
  group.avatar = File.open(Rails.root.join('db', 'fixtures', 'avatar2.jpg'))
  group.owner_id = 2
end

# タグ

mountain = Tag.find_or_create_by!(name: "山")
ocean = Tag.find_or_create_by!(name: "海")
offroad = Tag.find_or_create_by!(name: "オフロード")
onroad = Tag.find_or_create_by!(name: "オンロード")
opencar = Tag.find_or_create_by!(name: "オープンカー")
city = Tag.find_or_create_by!(name: "都市部")
suv = Tag.find_or_create_by!(name: "SUV")
sakura = Tag.find_or_create_by!(name: "桜")
subaru = Tag.find_or_create_by!(name: "スバル")
brz = Tag.find_or_create_by!(name: "BRZ")
suzuki = Tag.find_or_create_by!(name: "SUZUKI")


#ユーザー1

koki = Customer.find_or_create_by!(email: "koki@eample.com") do |customer|
    customer.name = "Koki"
    customer.profile_text = "カーライフを楽しんでます！"
    customer.password ="password"
    customer.avatar = File.open("./db/fixtures/avatar1.jpg")
end

koki.groups << suvlove

#ユーザー2

minato = Customer.find_or_create_by!(email: "minato@exampe.com") do |customer|
    customer.name = "Minato"
    customer.profile_text = "フォトスポットを巡ってます"
    customer.password ="password"
    customer.avatar = File.open("./db/fixtures/avatar3.jpg")
end

minato.groups << suvlove

#ユーザー3

kazu = Customer.find_or_create_by!(email: "kazu@example.com") do |customer|
    customer.name = "Kazu"
    customer.profile_text = "車大好き人間"
    customer.password ="password"
end

kazu.groups << drive

#ユーザー4

yuika = Customer.find_or_create_by!(email: "yuika@example.com") do |customer|
    customer.name = "Yuika"
    customer.profile_text = "最近ドライブにハマりました！"
    customer.password ="password"
end

yuika.groups << drive

#ユーザー5

yuki = Customer.find_or_create_by!(email: "yuki@example.com") do |customer|
    customer.name = "結城"
    customer.profile_text = "新車購入しました！"
    customer.password ="password"
    customer.avatar = File.open("./db/fixtures/avatar4.jpg")
end

#ユーザー6

leo = Customer.find_or_create_by!(email: "leo@example.com") do |customer|
    customer.name = "Leo"
    customer.profile_text = "よろしくお願いします！"
    customer.password ="password"
end

#ユーザー7
suzukilove = Customer.find_or_create_by!(email: "suzuki@example.com") do |customer|
    customer.name = "SUZUKI LOVE"
    customer.profile_text = "愛車Swiftと毎日を楽しんでます！"
    customer.password ="password"
end

suzukilove.groups << drive


#投稿1

Post.find_or_create_by!(title: "桜と撮りたい方におすすめ！") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample6.jpg"), filename:"sample6.jpg")
    post.detail = "雑誌のような１枚が撮れました！"
    post.prefecture_id = 28
    post.place = "宍粟市 山崎町"
    post.customer = leo
    post.tags << subaru
    post.tags << onroad
    post.tags << sakura
    post.tags << brz
end

#投稿2

Post.find_or_create_by!(title: "バックに四国と瀬戸内海が綺麗に撮れる場所") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample1.jpg"), filename:"sample1.jpg")
    post.detail = "遠出して撮影してきました！"
    post.prefecture_id = 33
    post.place = "倉敷市 鷲羽山展望台"
    post.customer = minato
    post.tags << ocean
    post.tags << onroad
end

#投稿3

Post.find_or_create_by!(title: "愛車と横浜までドライブ！！") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample3.jpg"), filename:"sample3.jpg")
    post.detail = "みなとみらいまで行きました！"
    post.prefecture_id = 14
    post.place = "横浜 みなとみらい"
    post.customer = kazu
    post.tags << opencar
    post.tags << city
    post.tags << onroad
end

#投稿4

Post.find_or_create_by!(title: "日本一の山を見に、、") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample4.jpg"), filename:"sample4.jpg")
    post.detail = "日本に住んでてよかったと実感した瞬間"
    post.prefecture_id = 22
    post.place = "富士宮市 富士山"
    post.customer = yuika
    post.tags << mountain
    post.tags << onroad
    post.tags << suv
end

#投稿5

Post.find_or_create_by!(title: "クルマだから楽しめるワインディングロード") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample5.png"), filename:"sample5.png")
    post.detail = "変化に富んだ山岳パノラマを満喫できる道中は、白根山や横手山など見どころが多い"
    post.prefecture_id = 10
    post.place = "草津温泉から志賀高原を抜け、湯田中渋温泉郷に至る道のり。"
    post.customer = yuki
    post.tags << mountain
    post.tags << onroad
end

#投稿6

Post.find_or_create_by!(title: "鳥取の桜絶景スポット") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample7.jpg"), filename:"sample7.jpg")
    post.detail = "愛車のSwiftと鳥取城跡までドライブ"
    post.prefecture_id = 31
    post.place = "鳥取市 鳥取城跡"
    post.customer = suzukilove
    post.tags << onroad
    post.tags << sakura
    post.tags << suzuki
end


#投稿7

Post.find_or_create_by!(title: "オフロードを最高に楽しむ") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample2.jpg"), filename:"sample2.jpg")
    post.detail = "オフロードを駆け抜けて撮影しました！"
    post.prefecture_id = 4
    post.place = "4x4 FIELD 4駆村"
    post.customer = koki
    post.tags << mountain
    post.tags << offroad
end
