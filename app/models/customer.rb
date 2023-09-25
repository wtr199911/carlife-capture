class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, authentication_keys: [:name]

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed

  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, presence: true, uniqueness: true

  validates :profile_image, content_type: ['image/png', 'image/jpeg']


   # 指定したユーザーをフォローする
  def follow(customer)
   active_relationships.create(followed_id: customer.id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(customer)
   active_relationships.find_by(followed_id: customer.id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(customer)
   followings.include?(customer)
  end

  # ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def guest_customer?
    email == GUEST_USER_EMAIL
  end

   # プロフィール画像呼び出しメソッド
  def get_profile_image(width, height)
   unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/profile_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def customer_status
    if is_valid == false
      "有効"
    else
      "退会"
    end
  end

  # 退会したユーザーがログインできないようにするためのメソッド
  def active_for_authentication?
    super && (is_valid == false)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.search_for(content, method)

   if method == 'perfect'
    Customer.where(name: content)

   elsif method == 'forward'
    Customer.where('name LIKE ?', content + '%')

   elsif method == 'backward'
    Customer.where('name LIKE ?', '%' + content)

   else
    Customer.where('name LIKE ?', '%' + content + '%')
   end
  end

  def create_notification_follow!(current_customer)
    temp = Notification.where(["customer_id = ? and action_type = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_type_notifications.new(
        customer_id: id,
        action_type: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
