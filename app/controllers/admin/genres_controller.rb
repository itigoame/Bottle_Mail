class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def create
    @category          = Category.find(params[:category_id])
    @genre             = Genre.new(genre_params)
    @genre.category_id = @category.id

    if @genre.save
      redirect_to request.referer
    else
      flash[:create_alret] = "投稿に失敗しました。もう一度お試しください"
      @genres = @category.genres.all
      redirect_to request.referer
    end

  end

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:category_id])
    @genre    = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to admin_category_path(@genre.category_id)
    else
      flash[:edit_alret] = "編集に失敗しました。もう一度お試しください"
      @genre    = Genre.find(params[:id])
      @category = Category.find(params[:category_id])
      render :edit
    end

  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to request.referer
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
