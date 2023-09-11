class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, authentication_keys: [:name]

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  has_one_attached :profile_image

   # プロフィール画像呼び出しメソッド
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end

  def customer_status
    if is_deleted == true
      "退会"
    else
      "有効"
    end
  end

  # 退会したユーザーがログインできないようにするためのメソッド
  def active_for_authentication?
    super && (is_deleted == false)
  end

end
