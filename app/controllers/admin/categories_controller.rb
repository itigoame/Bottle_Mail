class Admin::CategoriesController < ApplicationController

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to request.referer
    else
      @category = Category.new
      render :index
    end
  end

  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
