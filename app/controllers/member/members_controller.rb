class Member::MembersController < ApplicationController
  before_action :no_member, only: [:create]


  def show
      @member = Member.find(params[:id])
    if current_member.gender == @member.gender
      @following_members = @member.following_members
      @follower_members =  @member.follower_members
    else
      redirect_to member_path(current_member)
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @member = Member.find(params[:id])
  end

  def withdrawal
    @member = Member.find(params[:id])
    @member.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def follows
    member = Member.find(params[:id])
    @members = member.following_member
  end

  def followers
    member = Member.find(params[:id])
    @members = member.following_member
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :self_introduction, :is_active)
  end

  def no_member
    @member = Member.find_by(email: params[:member][:email])
    returm if !@member
    if @member.valid_password?(params[:member][:password]) && !@member.is_active
      redirect_to new_member_session_path
    end
  end
end
