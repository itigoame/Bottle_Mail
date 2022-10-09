class Post < ApplicationRecord
  belongs_to :member
  belongs_to :genre, optional: true
  belongs_to :category
  has_many :comments,  dependent: :destroy
  has_many :empathies, dependent: :destroy

  validates :title,       presence: true, length: { minimum: 1, maximum: 20 }
  validates :body,        presence: true, length: { minimum: 1, maximum: 300 }
end
