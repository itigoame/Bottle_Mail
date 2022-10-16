class Admin::RoomsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @room = Room.find(params[:id])
    @member = Member.find(params[:member_id])
    @chats = @room.chats
    @entries  = @room.entries
    @partner = @entries.where.not(member_id: @member.id).first
  end

  def index
    @member = Member.find(params[:member_id])
    @current_entries = @member.entries
  # roommenberを入れるための箱を作る
    current_room_index = []
    @current_entries.each do |entry|
      current_room_index << entry.room.id
    end
    @another_entries = Entry.where(room_id: current_room_index).where.not(member_id: @member.id)
  end
end
