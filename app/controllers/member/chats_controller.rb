class Member::ChatsController < ApplicationController
  before_action :authenticate_member!
  before_action :current_check, only: [:create, :destroy]

  def current_check
    @room = Room.find(params[:room_id])
    @entry = current_member.entries.find_by(room_id: @room.id)
    unless @entry.member.id == current_member.id
      redirect_to root_path
    end
  end

  def create
    @room  = Room.find(params[:room_id])
    @chat  = current_member.chats.new(chat_params)
    @chat.save
    @chats = @room.chats
    @room.create_notification_chat(current_member, @chat.id)
    redirect_to room_path(@room)
  end

  def destroy
    @chat  = current_member.chats.find_by(id: params[:id])
    @chat.destroy
    @chats = @room.chats
  end

  private
  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

end
