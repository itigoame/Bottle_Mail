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
    @room  = Room.find(params[:room_id])
    @chat  = current_member.chats.new(chat_params)
    @chat.save
    @chats = @room.chats
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
