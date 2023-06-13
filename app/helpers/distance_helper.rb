module DistanceHelper
  def distance(lat1, lon1, lat2, lon2)
    rad_per_deg = Math::PI / 180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    lat1_rad = lat1 * rad_per_deg
    lat2_rad = lat2* rad_per_deg

    dlat_rad = (lat2 - lat1) * rad_per_deg # Delta, converted to rad
    dlon_rad = (lon2 - lon1) * rad_per_deg

    a = (Math.sin(dlat_rad / 2)**2) + (Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad / 2)**2))
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    rm * c # Delta in meters
  end
end
