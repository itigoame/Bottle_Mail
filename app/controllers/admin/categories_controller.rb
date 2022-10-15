class Admin::CategoriesController < ApplicationController

  def create
    category = Category.new(category_params)

    if category.save
      redirect_back(fallback_location: root_url)
    else
      flash[:create_alret] = "投稿に失敗しました。もう一度お試しください"
      @category   = Category.new
      @categories = Category.all
      render :index
    end

  end

  def show
    @category = Category.find(params[:id])
    @genre    = Genre.new
    @genres   = @category.genres.all
  end

  def index
    @category   = Category.new
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      flash[:edit_alret] = "編集に失敗しました。もう一度お試しください"
      @category = Category.find(params[:id])
      render :edit
    end

  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to request.referer
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
