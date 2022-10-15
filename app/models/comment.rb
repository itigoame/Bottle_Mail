class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :post
  validates :body,length: { minimum: 1, maximum: 200 }
end
