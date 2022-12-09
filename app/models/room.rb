class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :chats,   dependent: :destroy

  #チャット通知
  def create_notification_chat(current_member, chat_id)
    @room_chat_ids = Entry.where(room_id: id).where.not(member_id: current_member.id)
    @another_entries = @room_chat_ids.find_by(room_id: id)
    notification = current_member.active_notifications.build(
      room_id: id,
      chat_id: chat_id,
      visited_id: @another_entries.member_id,
      action: 'room_chat'
    )

    notification.save if notification.valid?
  end


  # def save_notification_chat(current_member, chat_id, visited_id)
  #   # チャットは複数回やりとりするため、複数回通知する
  #   notification = current_member.active_notifications.new(
  #     room_id: id,
  #     chat_id: chat_id,
  #     visited_id: visited_id,
  #     action: 'room_chat'
  #   )
  #   # 自分のチャットは、通知済みとする
  #   if notification.visitor_id == notification.visited_id
  #     notification.checked = true
  #   end
  #   notification.save if notification.valid?
  # end

end
