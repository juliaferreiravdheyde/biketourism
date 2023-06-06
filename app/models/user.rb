class User < ApplicationRecord
  belongs_to :route
  has_many :favorites, dependent: :destroy
  has_many :rides, dependent: :destroy
  has_many :routes
end
