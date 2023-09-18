class Post < ApplicationRecord

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  belongs_to :customer
  # タグのリレーションのみ記載
  has_many :post_tag_relations, dependent: :destroy
  has_many :tags, through: :post_tag_relations

  attribute :name

  def favorited_by?(customer)
   favorites.exists?(customer_id: customer.id)
  end

  # 画像呼び出しメソッド
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
     end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["detail", "place", "prefecture_id", "title"]
  end

  def self.search(keyword)
    where("facility_name LIKE ? or address LIKE ? or detailed_description LIKE ?", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%")
  end

end
