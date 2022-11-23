class Member::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :corrent_check, only: [:update, :destroy]

  def corrent_check
    @post                  = Post.find(params[:id])
    unless @post.member.id == current_member.id
      redirect_to root_path
    end
  end

  def new
    @post       = Post.new
    @categories = Category.all
  end

  def create
    @post           = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      flash[:post_create_alret] = "投稿に失敗しました。もう一度お試しください"
      @post       = Post.new
      @categories = Category.all
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @post                    = Post.find(params[:id])
    if current_member.gender == @post.member.gender
      @member                = @post.member
      @empathies             = @post.empathies
      @comment               = Comment.new
      @comments              = @post.comments.includes(:member)
    else
      redirect_to root_path
    end
  end

  def index
    @category = Category.find(params[:category_id])
    @posts    = @category.posts.includes(:category, :genre, :comments, :empathies, :member).where(members: {gender: current_member.gender}).order(created_at: "DESC")
    @genres   = @category.genres

  end

  def update
    post   = Post.find(params[:id])
    member = post.member
    if post.update(post_params)
      redirect_to post_path(post.id)
    else
      render :show
    end
  end

  def destroy
    post      = Post.find(params[:id])
    member    = post.member
    if post.destroy
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
