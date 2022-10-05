class Post < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :comments,  dependent: :destroy
  has_many :empathies, dependent: :destroy
end
