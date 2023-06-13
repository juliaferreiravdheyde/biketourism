class Point < ApplicationRecord
  belongs_to :route
  validates :latitude, uniqueness: { scope: %i[longitude route_id] }
  validate :far_enough?

  geocoded_by :address

  def self.distance_between(point1, point2)
    distance(point1.latitude, point1.longitude, point2.latitude, point2.longitude)
  end

  private

  def far_enough?
    # some code to check distance between current point and the last one registered
    if Point.last.nil?
      true
    else
      Point.distance_between(Point.last, self) > 1.0
    end
  end
end
