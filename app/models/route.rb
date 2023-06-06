class Route < ApplicationRecord
  belongs_to :user
  has_many :users, :rides, :favorites, :points
end
