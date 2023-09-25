# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者登録
Admin.create!(email: "admin@email.com", password: "adminpass")

# 会員登録

# Customer.create!(name: "Yamada Taro", email: "yamada.taro@gmail.com", password: "111111")
# Customer.create!(name: "Sato Mamoru", email: "sato.mamoru@gmail.com", password: "111111")
# Customer.create!(name: "Saito Kazuma", email: "saito.kazuma@gmail.com", password: "111111")
# Customer.create!(name: "Noda Koki", email: "koki.noda@gmail.com", password: "111111")