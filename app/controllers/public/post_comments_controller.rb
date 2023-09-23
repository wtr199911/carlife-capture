class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    # 返信コメントの作成
    @comment_reply = @post.post_comments.new(post_comment_params)
    if @post_comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
    else
      @post_new = Post.new
      @customer_info = @post.customer
      @posts = Post.all
      flash.now[:alert] = "コメントの投稿に失敗しました。"
      render template: "posts/show"
    end
  end

  def create_reply
    @parent_comment = PostComment.find(params[:parent_id])
    @comment_reply = @parent_comment.replies.build(post_comment_params)
    @comment_reply.customer = current_customer

    if @comment_reply.save
      redirect_to post_path(@parent_comment.post), notice: "コメントに返信しました。"
    else
      flash.now[:alert] = "コメントの返信に失敗しました。"
      render template: "posts/show"
    end
  end

  def destroy
    # 返信フォームに渡しているインスタンス変数の追加（下記２行）
    @post = Post.find(params[:post_id])
    @comment_reply = @post.post_comments.new

    @comment = PostComment.find(params[:id]).destroy
    flash.now[:notice] = "コメントを削除しました。"
    render template: "posts/show"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit( :comment, :customer_id, :post_id, :parent_id)
  end

end
