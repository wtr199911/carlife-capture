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
    @posts = @customer.posts.order("created_at DESC").page(params[:page]).per(4)
    @count_posts = @customer.posts.count
    @customers = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
   if current_customer.update(customer_params)
     redirect_to mypage_path, notice: "編集が完了しました"
   else
     redirect_to information_path, alert: "編集に失敗しました"
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
    @post_page = Post.order("created_at DESC").page(params[:page]).per(6)
  end


  def timeline
   #フォローしているユーザーのみタイムラインに表示
   #N+1問題を防ぐためにincludesメソッド(gem: bulletを導入)を使用
    @posts_all = Post.includes(:customer,:tags,:favorites)

    @customer = Customer.find(current_customer.id)
   #フォローしているユーザーを取得
    @follow_users = @customer.followings
   #フォローユーザーの投稿を表示
    @posts = @posts_all.where(customer_id: @follow_users).order("created_at DESC").page(params[:page]).per(10)
    @posts.where(checked: false).each do |post|
      @customer = post.customer
      post.update(checked: true)
    end
  end



  private

  def customer_params
    params.require(:customer).permit( :name, :profile_text,  :avatar)
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
