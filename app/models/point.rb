class Point < ApplicationRecord
  belongs_to :route
  validates :latitude, :longitude, presence: true
end
