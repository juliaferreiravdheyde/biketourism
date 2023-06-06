class Route < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :rides
  has_many :favorites, dependent: :destroy
end
