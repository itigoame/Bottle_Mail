class Member::CategoriesController < ApplicationController
  before_action :authenticate_member!
  def index
    @categories = Category.all
  end

  def get_genres
    @genres = Genre.where(category_id: params[:category_id])
    render json: @genres
  end
end
