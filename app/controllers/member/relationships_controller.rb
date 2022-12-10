class Member::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    follower = Member.find(params[:member_id])
    current_member.follow(follower)
    follower.create_notification_follow(current_member)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    follower = Member.find(params[:member_id])
    current_member.unfollow(follower)
    redirect_back(fallback_location: root_url)
  end
end
