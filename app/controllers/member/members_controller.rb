class Member::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def edit
  end

  def unsubscribe
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :self_introduction, :is_active)
  end
end
