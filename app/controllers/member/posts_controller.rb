class Member::PostsController < ApplicationController
  def new
    @post = Post.new
    @categories = Category.all
    # @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    if @post.member_id = current_member.id
      @post.save!
      redirect_to posts_path
    else
      flash[:create_alret] = "投稿に失敗しました。もう一度お試しください"
      @post       = Post.new
      @categories = Category.all
      render :new
    end


  end

  def show
    @post = Post.find(params[:id])
    @member = @post.member
    @empathies = @post.empathies
  end

  def index
    @posts = Post.all
  end

  def destroy

  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :is_closed, :genre_id, :category_id)
  end
end
