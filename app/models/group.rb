class Group < ApplicationRecord

  has_many :group_users
  has_many :customers, through: :group_users

  validates :name, presence: true, length: { maximum: 10 }
  validates :introduction, length: { maximum: 20 }

  mount_uploader :avatar, GroupUploader

end
