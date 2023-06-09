class Point < ApplicationRecord
  belongs_to :route
  validates :latitude, uniqueness: { scope: %i[longitude route_id] }
  validate :far_enough?

  def self.distance_between(point1, point2)
    rad_per_deg = Math::PI / 180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    lat1_rad = point1.latitude * rad_per_deg
    lat2_rad = point2.latitude * rad_per_deg

    dlat_rad = (point2.latitude - point1.latitude) * rad_per_deg # Delta, converted to rad
    dlon_rad = (point2.longitude - point1.longitude) * rad_per_deg

    a = (Math.sin(dlat_rad / 2)**2) + (Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad / 2)**2))
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    rm * c # Delta in meters
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
