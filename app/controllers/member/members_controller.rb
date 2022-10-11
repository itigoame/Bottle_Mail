class Member::MembersController < ApplicationController
  before_action :no_member, only: [:create]


  def show
    @member = Member.find(params[:id])
    if current_member.gender == @member.gender
      @following_members = @member.following_members
      @follower_members  = @member.follower_members
      @posts = @member.posts

      # チャット機能
      @current_entry = Entry.where(member_id: current_member.id)
      @another_entry = Entry.where(member_id: @member.id)

      unless @member.id == current_member.id
        @current_entry.  each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        unless @is_room
          @room  = Room.new
          @entry = Entry.new
        end
      end

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
