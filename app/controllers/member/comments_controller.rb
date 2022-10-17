class Member::CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :corrent_check, only: [:destroy]

  def corrent_check
    @post = Post.find(params[:post_id])
    @comment = current_member.comments.find_by(post_id: @post.id)
    unless @comment.member.id == current_member.id
      redirect_to root_path
    end
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_member.comments.new(comment_params)
    comment.post_id = post.id
      if comment.save
        redirect_back(fallback_location: root_url)
      else
        flash[:comment_create_alret] = "投稿に失敗しました。もう一度お試しください"
        @post      = Post.find(params[:post_id])
        @member    = @post.member
        @empathies = @post.empathies
        @comment   = Comment.new
        @comments  = @post.comments
        render template: "member/posts/show"

      end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = current_member.comments.find_by(post_id: post.id)
    comment.destroy
    redirect_back(fallback_location: root_url)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
