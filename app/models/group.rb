class Group < ApplicationRecord

  has_many :group_users
  has_many :customers, through: :group_users

  validates :name, presence: true, length: { maximum: 10 }
  validates :introduction, length: { maximum: 20 }

  mount_uploader :avatar, GroupUploader

  def includesUser?(customer)
    group_users.exists?(customer_id: customer.id)
  end

  def self.search_for(content, method)

   if method == 'perfect'
    Group.where(name: content)

   elsif method == 'forward'
    Group.where('name LIKE ?', content + '%')

   elsif method == 'backward'
    Group.where('name LIKE ?', '%' + content)

   else
    Group.where('name LIKE ?', '%' + content + '%')
   end
  end

end
