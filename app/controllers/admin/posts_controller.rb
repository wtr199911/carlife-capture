class Admin::PostsController < ApplicationController

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
    posts = Post.find(params[:id])
    posts.destroy
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

  private

  def post_params
    params.require(:post).permit(:title, :image, :detail, :place, :prefecture_id, :name)
  end

end
