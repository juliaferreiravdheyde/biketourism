class Route < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :rides
  has_many :points, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :photos

  def total_distance
    distance = 0
    (points.length - 1).times do |i|
      loc1 = points[i]
      loc2 = points[i + 1]
      rad_per_deg = Math::PI / 180  # PI / 180
      rkm = 6371                  # Earth radius in kilometers
      rm = rkm * 1000             # Radius in meters

      dlat_rad = (loc2.latitude - loc1.latitude) * rad_per_deg  # Delta, converted to rad
      dlon_rad = (loc2.longitude - loc1.longitude) * rad_per_deg

      lat1_rad = loc1.latitude * rad_per_deg
      lon1_rad = loc1.longitude * rad_per_deg

      lat2_rad =  loc2.latitude * rad_per_deg
      long2_rad = loc2.longitude * rad_per_deg

      a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

      distance += rm * c # Delta in meters
    end
    distance.to_i
  end
end
