class Admin::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
    else
     @post_new = Post.new
     @customer_info = @post.customer
     @posts = Post.all
     render template: "posts/show"
    end
  end

  def destroy
    @comment = PostComment.find(params[:id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
