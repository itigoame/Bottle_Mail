class Category < ApplicationRecord
  has_many :genres, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def no_genre
    unless genres.present?
      "ジャンルはありません"
    end
  end
end
