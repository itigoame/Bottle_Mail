class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  enum gender: { women: 0, men: 1 }

  validates :name, :self_introduction, presence: true

  has_many :comments, dependent: :destroy
  has_many :empathys, dependent: :destroy
  has_many :posts,    dependent: :destroy
  has_many :entries,  dependent: :destroy
  has_many :chats,    dependent: :destroy
  has_many :rooms,    dependent: :destroy

  has_many :followers, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :follower_members, through: :followers, source: :followed #自分がフォローしてる人一覧

  has_many :followings, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :following_members, through: :followings, source: :follower #自分がフォローされてる人一覧

end
