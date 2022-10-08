class Member::RelationshipsController < ApplicationController

  def create
    follower = Member.find(params[:member_id])
    current_member.follow(follower)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    follower = Member.find(params[:member_id])
    current_member.unfollow(follower)
    redirect_back(fallback_location: root_url)
  end
end
