class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    room = Room.find(params[:room_id])
    chat = Chat.find_by(room_id: room.id)
    member_id = chat.member.id
    chat.destroy
    redirect_back(fallback_location: root_url)
  end

  private
  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

end
