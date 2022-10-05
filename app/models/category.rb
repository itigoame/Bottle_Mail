class Category < ApplicationRecord
  has_many :genres, dependent: :destroy
end
