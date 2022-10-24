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

end
