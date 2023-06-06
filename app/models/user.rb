class User < ApplicationRecord
  belongs_to :route
  has_many :favorites, :rides, :routes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
