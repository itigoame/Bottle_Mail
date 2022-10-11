class Member::RoomsController < ApplicationController
  def create
    room = Room.create
    current_entry = Entry.create(member_id: current_member.id,          room_id: room.id)
    another_entry = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(room.id)
  end

  def show
  end

  def index
  end
end
