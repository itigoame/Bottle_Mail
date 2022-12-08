class Post < ApplicationRecord
  belongs_to :member
  belongs_to :genre,   optional: true
  belongs_to :category
  has_many :comments,  dependent: :destroy
  has_many :empathies, dependent: :destroy

  validates :title,       presence: true, length: { minimum: 1, maximum: 20 }
  validates :body,        presence: true, length: { minimum: 1, maximum: 250 }
  validates :category,    presence: true

  def closed_check
    if is_closed == false
      "トーク中"
    else
      "トーク終了"
    end
  end

  # 検索
  def self.looks(word)
    if word
      @post = Post.where("title LIKE ? OR body LIKE ?","%#{word}%","%#{word}%")
    else
      @post = Post.all
    end
  end

  def empathy_by?(member)
    empathies.exists?(member_id: member.id)
  end

  #コメント通知
  def create_notification_comment(current_member,visited_id)
    visit_comment_ids = Comment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct
    #自分以外にコメントしている人全員に通知
    visit_comment_ids.each do |visit_comment_id|
      save_notification_comment(current_member, comment_id, visit_comment_id["member_id"])
    end
    #コメント0件の場合は投稿者にのみ通知
    save_notification_comment(current_member, comment_id, member_id) if visit_comment_ids.blank?
  end

  def save_notification_comment(current_member, comment_id, visited_id)
    #コメントするたびに通知する
    notification = current_member.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )

    #自分の投稿は通知済みにして送らない
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  #フォロー通知
  def create_notification_follow(current_member)
    visit_follow = Notification.where(["visitor_id = ? and visited_id = ? and action = ?",current_member.id, id, "follow"])
    #同一の通知レコードがない場合のみ通知
    if visit_follow.blank?
      notification = current_member.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

end
