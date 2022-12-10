class Chat < ApplicationRecord
  belongs_to :member
  belongs_to :room
  has_many   :notifications, dependent: :destroy
  validates :message,length: { minimum: 1, maximum: 500 }
end
