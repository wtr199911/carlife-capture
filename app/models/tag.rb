class Tag < ApplicationRecord

  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations

  validates :name, presence:true, length:{ maximum:10 }

  def self.all_tags_valid?(tags)
    tags.all? { |tag| Tag.new(name:tag).valid? }
  end
end
