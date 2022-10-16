class Member::ChatsController < ApplicationController
  before_action :authenticate_member!
  before_action :corrent_check, only: [:destroy]

  def corrent_check
    @room = Room.find(params[:room_id])
    @chat = current_member.chats.find_by(room_id: @room.id)
    unless @chat.member.id = current_member.id
      redirect_to root_path
    end
  end

  def create
    room = Room.find(params[:room_id])
    chat = current_member.chats.new(chat_params)

    if chat.member_id == current_member.id
      if chat.save
        redirect_back(fallback_location: root_path)
      else
      flash[:create_alret] = "投稿に失敗しました。もう一度お試しください"
      @room     = Room.find(params[:room_id])
      @chat     = Chat.new
      @chats    = @room.chats
      @entries  = @room.entries
      @partner  = @entries.where.not(member_id: current_member.id).first
      render template: "member/rooms/show"
      end
    else
      redirect_to rooms_path
    end
  end

  def destroy
    room = Room.find(params[:room_id])
    chat = current_member.chats.find_by(room_id: room.id)
    chat.destroy
    redirect_back(fallback_location: root_url)
  end

  private
  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

end
