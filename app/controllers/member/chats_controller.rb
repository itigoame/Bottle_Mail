class Member::ChatsController < ApplicationController
  before_action :authenticate_member!
  before_action :corrent_check, only: [:create, :destroy]

  def corrent_check
    @room = Room.find(params[:room_id])
    @chat = current_member.chats.find_by(room_id: @room.id)
    unless @chat.member.id == current_member.id
      redirect_to root_path
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @chat = current_member.chats.new(chat_params)
    if @chat.save
      redirect_back(fallback_location: root_path)
    else
      flash[:chat_create_alret] = "送信に失敗しました。もう一度お試しください"
      @chats    = @room.chats
      @entries  = @room.entries
      @partner  = @entries.where.not(member_id: current_member.id).first
      redirect_back(fallback_location: root_path)
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
