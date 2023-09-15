class PostTagRelation < ApplicationRecord

  belongs_to :tag
  belongs_to :post

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

end
