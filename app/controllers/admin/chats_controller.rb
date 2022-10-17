class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    chat = Chat.find_by(id: params[:id])
    chat.destroy if chat
    redirect_back(fallback_location: root_url)
  end

  private
  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

end
