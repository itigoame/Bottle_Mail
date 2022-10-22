class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit:[width,height]).processed
  end

  # 退会確認
  def active_for_authentication?
    super && (is_active == true)
  end

  def status_display
    if is_active == true
      "会員"
    else
      "非会員"
    end
  end

  enum gender: { men: 1, women: 2, }

  validates :name, presence: true,length: { minimum: 1, maximum: 20 }
  validates :self_introduction,length: { maximum: 100 }

  has_many :comments,  dependent: :destroy
  has_many :empathies, dependent: :destroy
  has_many :posts,     dependent: :destroy
  has_many :entries,   dependent: :destroy
  has_many :chats,     dependent: :destroy
  has_many :rooms,     dependent: :destroy

  #フォロー機能
  has_many :followers,        class_name: "Relationship",foreign_key: :follower_id, dependent: :destroy
  has_many :follower_members, through: :followers, source: :followed #自分がフォローしてる人一覧

  has_many :followings,        class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :following_members, through: :followings, source: :follower #自分がフォローされてる人一覧

  def follow(member)
    followers.find_or_create_by(followed_id: member.id)
  end

  def unfollow(member)
    follower = followers.find_by(followed_id: member.id)
    follower.destroy if follower
  end

  def following?(member)
    follower_members.include?(member)
  end

  # member側検索
  def self.looks(word)
    if word
      @member = Member.where("name LIKE ? OR self_introduction LIKE ?","%#{word}%","%#{word}%")
      # where('title LIKE ? OR body LIKE ?', "%#{keyword}%", "%#{keyword}%")
    else
      @member = Member.all
    end
  end

  # admin側検索(表示させるページが異なるため分ける)
  def self.look(word)
    if word
      @member = Member.where("name LIKE ? OR self_introduction LIKE ?","%#{word}%","%#{word}%")
    else
      @member = Member.all
    end
  end
end
