class Member::PostsController < ApplicationController
  def new
    @post = Post.new
    @categories = Category.all
    @genres = Genre.all
  end

  def create

  end

  def show
  end

  def index
  end

  def destroy

  end

  private
  def post_params
    params.require(:post).permin(:title, :body, :is_closed, :member_id, :genre_id)
  end
end
