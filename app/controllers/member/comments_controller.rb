class Member::CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :corrent_check, only: [:destroy]

  def corrent_check
    @post    = Post.find(params[:post_id])
    @comment = current_member.comments.find_by(post_id: @post.id)
    unless @comment.member.id == current_member.id
      redirect_to root_path
    end
  end

  def create
    @post    = Post.find(params[:post_id])
    @comments  = @post.comments
    @comment = current_member.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
  end

  def destroy
    @post      = Post.find(params[:post_id])
    @comments  = @post.comments
    @comment   = current_member.comments.find_by(id: params[:id], post_id: @post.id)
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
