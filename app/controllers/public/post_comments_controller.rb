class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    # 返信コメントの作成
    @comment_reply = @post.post_comments.new
    unless @post_comment.save
      render 'error'
    end
  end

  def destroy
    # 返信フォームに渡しているインスタンス変数の追加（下記２行）
    @comment = PostComment.find(params[:id])
    @post = @comment.post # コメントに紐づく投稿を取得
    @comment_reply = @post.post_comments.new

    @comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit( :comment, :customer_id, :post_id, :parent_id)
  end

end
