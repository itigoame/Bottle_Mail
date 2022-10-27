class Admin::MembersController < ApplicationController
    before_action :authenticate_admin!

  def show
    @member            = Member.find(params[:id])
    @following_members = @member.following_members
    @follower_members  = @member.follower_members
    @posts             = @member.posts.order(created_at: "DESC")
  end

  def index
    @members = Member.all
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to admin_member_path(@member.id)
    else
      flash[:edit_alret] = "編集に失敗しました。もう一度お試しください"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :self_introduction, :is_active)
  end
end
