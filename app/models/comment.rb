class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :post
  has_many   :notifications, dependent: :destroy
  validates :body,length: { minimum: 1, maximum: 500 }
end
