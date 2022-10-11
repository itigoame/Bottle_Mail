class Admin::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
    @following_members = @member.following_members
    @follower_members =  @member.follower_members
    @posts = @member.posts
  end

  def index
    @members = Member.all
  end

  def edit

  end

  def update

  end
end
