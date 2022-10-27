class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :no_member,     only: [:create]
  before_action :current_check, only: [:edit, :update, :unsubscribe, :withdrawal]

  # 退会後ログイン防止
  def no_member
    @member = Member.find_by(email: params[:member][:email])
    returm if !@member
    if @member.valid_password?     (params[:member][:password]) && !@member.is_active
      redirect_to new_member_session_path
    end
  end

  def current_check
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to root_path
    end
  end

  def show
    @member                  = Member.find(params[:id])
    if current_member.gender == @member.gender
      @following_members     = @member.following_members
      @follower_members      = @member.follower_members
      @posts                 = @member.posts.order(created_at: "DESC")

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
      flash[:self_create_alret] = "更新に失敗しました。もう一度お試しください"
      redirect_back(fallback_location: root_path)
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

  def followings
    @member  = Member.find(params[:member_id])
    @members = @member.following_members
  end

  def followers
    @member  = Member.find(params[:member_id])
    @members = @member.follower_members
  end

  private

  def member_params
    params.require(:member).permit(:name, :profile_image, :self_introduction, :is_active)
  end

end
