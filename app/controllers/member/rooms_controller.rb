class Member::RoomsController < ApplicationController
  before_action :authenticate_member!

  def create
    room          = Room.create
    current_entry = Entry.create(member_id: current_member.id, room_id: room.id)
    another_entry = Entry.create(params.require(:entry).permit(:member_id, :room_id).merge(room_id: room.id))
    redirect_to room_path(room.id)
  end

  def show
    @room = Room.find(params[:id])

    if Entry.where(member_id: current_member.id, room_id: @room.id).present?
      @chat       = Chat.new
      @chats      = @room.chats
      @entries    = @room.entries
      @partner    = @entries.where.not(member_id: current_member.id).first
      @partner_id = @partner.member.id
    else
      redirect_to member_path(current_member)
    end

  end

  def index
  @current_entries     = current_member.entries
  # roommenberを入れるための箱を作る
    current_room_index = []
  @current_entries.each do |entry|
    current_room_index << entry.room.id
  end
  @another_entries = Entry.where(room_id: current_room_index).where.not(member_id: current_member.id)
  end
end
