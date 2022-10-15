class Chat < ApplicationRecord
  belongs_to :member
  belongs_to :room
  validates :message,length: { minimum: 1, maximum: 300 }
end
