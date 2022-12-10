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
  def create_notification_comment(current_member, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    post_comment_ids = Comment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct
    post_comment_ids.each do |post_comment_id|
      save_notification_comment(current_member, comment_id, post_comment_id['member_id'])
      save_notification_comment(current_member, comment_id, member_id)
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_member, comment_id, member_id) if post_comment_ids.blank?
  end

  def save_notification_comment(current_member, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
