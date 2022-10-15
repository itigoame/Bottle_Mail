class Admin::CommentsController < ApplicationController
  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find_by(post_id: post.id)
    comment.destroy
    redirect_to admin_members
  end
end
