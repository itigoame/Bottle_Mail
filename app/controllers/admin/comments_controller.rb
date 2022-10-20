class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    post    = Post.find(params[:post_id])
    comment = Comment.find_by(post_id: post.id)
    comment.destroy
    redirect_back(fallback_location: root_url)
  end
end
