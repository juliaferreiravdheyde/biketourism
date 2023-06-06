class User < ApplicationRecord
  belongs_to :route
  has_many :favorites, :rides, :routes
end
