class SearchesController < ApplicationController

  # 名前・自己紹介文・投稿内容で検索
  def search
    @range = params[:range]
    if @range == "Member"
      @members = Member.looks(params[:word]).where(gender: current_member.gender) if member_signed_in?
      @members = Member.looks(params[:word]) if admin_signed_in?
    else
      @category = Category.find(params[:category_id])
      if params[:genre_id]
        @posts = Post.includes(:member).where(genre_id: params[:genre_id]).where(members: {gender: current_member.gender}).order(created_at: "DESC") if member_signed_in?
        @posts = Post.where(genre_id: params[:genre_id]).order(created_at: "DESC") if admin_signed_in?
      else
        @posts = Post.includes(:member).looks(params[:word]).where(members: {gender: current_member.gender}).order(created_at: "DESC") if member_signed_in?
        @posts = Post.looks(params[:word]).order(created_at: "DESC") if admin_signed_in?
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
