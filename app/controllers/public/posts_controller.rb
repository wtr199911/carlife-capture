class Public::PostsController < ApplicationController

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
    @posts = Post.all
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @tag_list = @post.tags.pluck(:name).join(",")
    @post_tags = @post.tags
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
    @posts = @tag.posts
  end

  def self.ransackable_attributes(auth_object = nil)
    ["detail", "place", "prefecture_id", "title"]
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :detail, :place, :prefecture_id, :name)
  end

end
