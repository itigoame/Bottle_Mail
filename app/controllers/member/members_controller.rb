class Member::MembersController < ApplicationController
  def show
    @cu = Member.find(params[:id])
  end

  def edit
  end

  def unsubscribe
  end

  private

  def member_params
    params.require(:member).permit(:name)
  end
end
