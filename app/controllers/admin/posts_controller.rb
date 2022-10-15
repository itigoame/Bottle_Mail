class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @member = @post.member
    @empathies = @post.empathies
    @comment = Comment.new
    @comments = @post.comments
  end

  def index
    @category = Category.find(params[:category_id])
    @posts = @category.posts.order(created_at: "DESC")
    @genres = @category.genres
  end

  def destroy
    post = Post.find(params[:id])
    member = post.member.id
    post.destroy
    redirect_to admin_member_path(member)
  end
end
