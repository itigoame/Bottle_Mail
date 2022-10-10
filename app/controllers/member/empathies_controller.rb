class Member::EmpathiesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    empathy = current_member.empathies.new(post_id: post.id)
    empathy.save
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post = Post.find(params[:post_id])
    empathy = current_member.empathies.find_by(post_id: post.id)
    empathy.destroy
    redirect_back(fallback_location: root_url)
  end

end
