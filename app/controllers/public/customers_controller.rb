class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]
  before_action :authorize_access

  def mypage
    @customer = current_customer
    @posts = @customer.posts.order("created_at DESC").page(params[:page]).per(4)
    @count_posts = @customer.posts.count
  end

  def show
    @customer = Customer.find(params[:id])
    @post = Post.find(params[:id])
    @posts = @customer.posts.order("created_at DESC").page(params[:page]).per(4)
    @count_posts = @customer.posts.count
    @customer_info = @post.customer
  end

  def edit
    @customer = current_customer
  end

  def update
   if current_customer.update(customer_params)
     redirect_to mypage_path
   else
     redirect_to infomation_path
   end
  end

  def confirm_withdraw
  end

  def withdraw
    current_customer.update(is_valid: true)
    reset_session
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @customers = @customer.favorites
    @favorite_posts = Post.find(favorites)
    @post = Post.find(params[:id])
    @post_page = Post.order("created_at DESC").page(params[:page]).per(6)
  end

  private

  def customer_params
    params.require(:customer).permit( :name, :profile_image, :profile_text)
  end

  def authorize_access
    # 管理者か会員のいずれかであればアクセスを許可
    unless admin_signed_in? || customer_signed_in?
      redirect_to root_path
    end
  end

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to mypage_path(current_customer), notice: "ゲストユーザーは編集できません。"
   end
  end


end
