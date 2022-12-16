class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(date)
    ActionCable.server.broadcast ‘room_channel’, chat: data[‘chat’]
  end
end
