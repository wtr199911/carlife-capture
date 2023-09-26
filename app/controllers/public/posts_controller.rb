class Public::PostsController < ApplicationController
  before_action :ensure_guest_customer, only: [:new]
  before_action :authorize_access

  def new
    @post = Post.new
    @post_tags = @post.tags
  end

  def create
    @post = current_customer.posts.build(post_params)
    tag_list=params[:post][:name].split(",")
    current_tags = @post.current_tags
    new_tags = @post.new_tags(tag_list, current_tags)
    if Tag.all_tags_valid?(new_tags)
      if @post.update(post_params)
        tag_list = tag_list.uniq
        @post.save_tags(tag_list, current_tags, new_tags)
        flash[:notice] = "投稿しました。"
        redirect_to post_path(@post)
      else
        render :new, alert: "投稿に失敗しました"
      end
    else
      @post.errors.add(:base, "タグは10文字以内にして下さい")
      render :new
    end
  end

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @post = @posts.order("created_at DESC").page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @tag_list = @post.tags.pluck(:name).join(",")
    @post_tags = @post.tags
    @customer_info = @post.customer
    # 返信コメント
    @comment_reply = @post.post_comments.new
  end

  def edit
    @post = Post.find(params[:id])
    @post.name = @post.tags.pluck(:name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(",")
    current_tags = @post.current_tags
    new_tags = @post.new_tags(tag_list, current_tags)
    if Tag.all_tags_valid?(new_tags)
      if @post.update(post_params)
        tag_list = tag_list.uniq
        @post.save_tags(tag_list, current_tags, new_tags)
        flash[:notice] = "投稿を更新しました。"
        redirect_to post_path(@post)
      else
        render :edit, alert: "編集に失敗しました"
      end
    else
      @post.errors.add(:base, "タグは10文字以内にして下さい")
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, alert: "投稿を削除しました"
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @post = @tag.posts
    @posts = @post.order("created_at DESC").page(params[:page]).per(5)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["detail", "place", "prefecture_id", "title"]
  end

  def create_favorite
    # current_customer から必要な情報を取得
    customer_id = current_customer.id
    post_id = params[:post_id]

    # Notification モデルのメソッドを呼び出し
    Notification.create_favorite(customer_id, post_id)
  end

  def create_post_comment
    # current_customer から必要な情報を取得
    customer_id = current_customer.id
    post_id = params[:post_id]

    # Notification モデルのメソッドを呼び出し
    Notification.create_post_comment(customer_id, post_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :detail, :place, :prefecture_id, :name, :tags)
  end

  def authorize_access
    # 管理者か会員のいずれかであればアクセスを許可
    unless admin_signed_in? || customer_signed_in?
      redirect_to root_path, alert: "ゲストログイン・新規登録・ログインをして下さい。"
    end
  end

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to mypage_path(current_customer), alert: "ゲストユーザーは投稿できません。"
   end
  end

end
