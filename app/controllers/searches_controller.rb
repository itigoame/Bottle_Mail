class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "Member"
      @members = Member.looks(params[:word])
    else
      if params[:genre_id]
        @posts = Genre.looks(params[:genre_id])
      else
        @posts = Post.looks(params[:word])
      end
      @genres = Genre.all
      if member_signed_in?
        render "member/posts/index"
      elsif admin_signed_in?
        render "admin/posts/index"
      end
    end
  end
end
