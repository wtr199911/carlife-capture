class Public::PostsController < ApplicationController
  before_action :ensure_guest_customer, only: [:new]

  def new
    @post = Post.new
    @post_tags = @post.tags
  end

  def create
    @post = current_customer.posts.build(post_params)
    # 受け取った値を,で区切って配列にする
    tag_list = @post.name.split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path, notice: "投稿が完了しました"
    else
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
  end

  def edit
    @post = Post.find(params[:id])
    @post.name = @post.tags.pluck(:name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(",")
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    posts = Post.find(params[:id])
    posts.destroy
    redirect_to posts_path
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

  private

  def post_params
    params.require(:post).permit(:title, :image, :detail, :place, :prefecture_id, :name)
  end

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to mypage_path(current_customer), notice: "ゲストユーザーは投稿できません。"
   end
  end

end
