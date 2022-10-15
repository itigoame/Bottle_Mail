class Genre < ApplicationRecord
  belongs_to :category
  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  # 検索
  def self.looks(genre_id)
    if genre_id
      Post.where(genre_id: genre_id)
    else
      Post.all
    end
  end

end
