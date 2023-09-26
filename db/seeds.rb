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

mountain = Tag.find_or_create_by!(name: "山")
ocean = Tag.find_or_create_by!(name: "海")
offroad = Tag.find_or_create_by!(name: "オフロード")
onroad = Tag.find_or_create_by!(name: "オンロード")

#ユーザー1

koki = Customer.find_or_create_by!(email: "koki@example.com") do |customer|
    customer.name = "Koki"
    customer.profile_text = "カーライフを楽しんでます！"
    customer.password ="password"
end

#ユーザー2

minato = Customer.find_or_create_by!(email: "minato@example.com") do |customer|
    customer.name = "Minato"
    customer.profile_text = "フォトスポットを巡ってます"
    customer.password ="password"
end


#投稿1

Post.find_or_create_by!(title: "オフロードを最高に楽しむ") do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample2.jpg"), filename:"sample2.jpg")
    post.detail = "オフロードを駆け抜けて撮影しました！"
    post.prefecture_id = 4
    post.place = "4x4 FIELD 4駆村"
    post.customer = koki
    post.tags << mountain
    post.tags << offroad
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