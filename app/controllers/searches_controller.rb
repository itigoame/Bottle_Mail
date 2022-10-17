class SearchesController < ApplicationController

  # 名前・自己紹介文・投稿内容で検索
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

  # 性別・名前・自己紹介文で検索
  def admin_search
     @range = params[:range]

    if @range == "男性"
      @member = Member.look(params[:word])
      @members = @member.where(gender: "men")
      render "admin/members/index"
    elsif @range == "女性"
      @member = Member.look(params[:word])
      @members = @member.where(gender: "women")
      render "admin/members/index"
    elsif @range == "全て"
      @member = Member.look(params[:word])
      @members = @member.all
      render "admin/members/index"
    else
      @members = Member.all
      render "admin/members/index"
    end
  end
end
