require "json"
require "open-uri"

class Route < ApplicationRecord
  include PgSearch::Model
  belongs_to :creator, class_name: "User"
  has_many :rides
  has_many :points, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :photos


  validates :name, presence: true, length: { minimum: 5 }
  validates :type_of_route, presence: true

  TYPE_OF_ROUTE = ['Urban', 'Suburban', 'CountrySide', 'Mountain']

  pg_search_scope :search_by_type_of_route, against: :type_of_route

  pg_search_scope :search_by_distance, against: :distance

  def total_distance
    distance = 0
    (points.length - 1).times do |i|
      distance += Point.distance_between(points[i], points[i + 1]) # Delta in meters
    end
    distance.to_i
  end

  def total_positive_elevation
    n = points.length - 1 # Number of intervals between points
    if n > 100
      interval = n.to_f / (100 - 1) # Interval size

      sampled_points = []
      (0...100).times do |i|
        sampled_points << points[(interval * i).round] # getting elements at even intervals
      end
    else
      sampled_points = points
    end

    positive_elevation = 0
    # negative_elevation = 0
    elevations = sampled_points.map do |point|
      url = "https://api.mapbox.com/v4/mapbox.mapbox-terrain-v2/tilequery/#{point.longitude},#{point.latitude}.json?limit=50&layers=contour&access_token=#{ENV['MAPBOX_API_KEY']}"
      response = URI.open(url).read
      JSON.parse(response)['features'].last['properties']['ele']
    end
    (elevations.length - 1).times do |i|
      positive_elevation += elevations[i + 1] > elevations[i] ? elevations[i + 1] - elevations[i] : 0
      # negative_elevation -= elevations[i + 1] < elevations[i] ? elevations[i + 1] - elevations[i] : 0
    end
    # p negative_elevation
    positive_elevation
  end
end
