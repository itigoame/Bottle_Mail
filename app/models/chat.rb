class Chat < ApplicationRecord
  belongs_to :member
  belongs_to :room
  validates :message,length: { minimum: 1, maximum: 500 }
end
