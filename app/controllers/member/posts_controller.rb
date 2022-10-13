class Member::PostsController < ApplicationController
  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
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
    if current_member.gender == @post.member.gender
      @member = @post.member
      @empathies = @post.empathies
      @comment = Comment.new
      @comments = @post.comments
    else
      redirect_to posts_path
    end
  end

  def index
    # @category = Category.find(params[:category_id])
    # @posts = @category.posts
    @posts = Post.all
  end

  def update
    post = Post.find(params[:id])
    member = post.member
    if post.update(post_params)
      redirect_to post_path(post.id)
    else
      render :show
    end
  end

  def destroy
    post = Post.find(params[:id])
    member = post.member
    if member == current_member
      post.destroy
      redirect_to member_path(member.id)
    else
      redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :category_id, :is_closed)
  end
end
