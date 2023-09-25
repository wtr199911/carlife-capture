class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post
  belongs_to :parent, class_name: "PostComment", optional: true

  has_many :replies, class_name: "PostComment", foreign_key: :parent_id, dependent: :destroy

  validates :comment,presence: true, length: { maximum: 100 }

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
      # 通知を作成する前に、コメントしたユーザーが投稿の作者と一致しない場合に通知を作成
    if self.customer != self.post.customer
      Notification.create(subject: self, customer: post.customer, action_type: :commented_to_own_post)
    end
  end

end
