class Member::EnpathiesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    enpathy = current_member.enpathies.new(post_id: post.id)
    post.save
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post = Post.find(params[:post_id])
    enpathy = current_member.enpathies.find(post_id: post.id)
    enpathy.destroy
    redirect_back(fallback_location: root_url)
  end

end
