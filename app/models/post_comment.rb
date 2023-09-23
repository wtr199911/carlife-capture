class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post
  belongs_to :parent, class_name: "PostComment", optional: true

  has_many :replies, class_name: "PostComment", foreign_key: :parent_id, dependent: :destroy

  validates :comment,presence: true, length: { maximum: 200 }

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private
  def create_notifications
    Notification.create(subject: self, customer: post.customer, action_type: :commented_to_own_post)
  end

end
