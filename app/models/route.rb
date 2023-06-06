class Route < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :rides
  has_many :favorites, dependent: :destroy
end
