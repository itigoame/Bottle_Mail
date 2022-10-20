class Member::EmpathiesController < ApplicationController
  before_action :authenticate_member!
  def create
    @post        = Post.find(params[:post_id])
    if !current_member.empathies.find_by(post_id: @post.id)
      @empathy   = current_member.empathies.new(post_id: @post.id)
      @empathy.save
      @empathies = @post.empathies
    end
  end

  def destroy
    @post      = Post.find(params[:post_id])
    @empathy   = current_member.empathies.find_by(post_id: @post.id)
    @empathy.destroy
    @empathies = @post.empathies
  end

end
