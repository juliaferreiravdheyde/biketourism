require 'open-uri'
require 'unsplash'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Point.destroy_all
Ride.destroy_all
Favorite.destroy_all

User.all.each { |user| user.update!(pinned_route_id: nil) }
Route.destroy_all
User.destroy_all

user1 = User.create!(first_name: "joao", email: "joao@gmail.com", password: "123123")
user2 = User.create!(first_name: "paulo", email: "paulo@gmail.com", password: "123123")
user3 = User.create!(first_name: "alphadeny", email: "alphadeny@hotmail.fr", password: "123123")
user4 = User.create!(first_name: "thiago", email: "thiago@olatu.com", password: "123123")
user5 = User.create!(first_name: "julia", email: "juliavdheyde@icloud.com", password: "123123")

Unsplash.configure do |config|
  config.application_access_key = ENV["VTQ67nHQkRqw3SRhF-Yaq0qq11vlvjUfeyWMt5UhfOg"]
  config.application_secret = ENV["zKS0HfCBW3SODlEyGK9I_AOwnu2JtltaN4oQZ5_s2JQ"]
  #config.application_redirect_uri = "https://your-application.com/oauth/callback"
  #config.utm_source = "alices_terrific_client_app"

  route1 = Route.new(
    name: "Rota Parque do Ibirapuera",
    description: "Trilha muito tranquilha ao redor do Parque",
    type_of_route: "Urban",
    positive_elevation: 1.5,
    creator: user3
  )

  route2 = Route.new(
    name: "Rota Centro de SP",
    description: "passeio pelo pontos históricos no centro da cidade",
    type_of_route: "Urban",
    positive_elevation: 2.9,
    creator: user5
  )

  route1.save(validate: false)
  route2.save(validate: false)

  coordinates = [
    [-23.442864647150547, -46.774944091838236],
    [-23.443652042248406, -46.772733962786326],
    [-23.44728535490771, -46.772373403454196],
    [-23.450993849417785, -46.77316215199228],
    [-23.44968232057618, -46.7654225569623],
    [-23.451709873668655, -46.76633455406208],
    [-23.453146894935216, -46.76647407787007],
    [-23.45547267151323, -46.76657391345817],
    [-23.45745097397038, -46.765919444006045],
    [-23.457474156473904, -46.76705879170353],
    [-23.458350134024258, -46.7669407858058]
  ]

  coordinates.each do |coordinate|
    route1.points
    route1.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-23.442864647150547, -46.774944091838236],
    [-23.443652042248406, -46.772733962786326],
    [-23.44728535490771, -46.772373403454196],
    [-23.450993849417785, -46.77316215199228],
    [-23.44968232057618, -46.7654225569623],
    [-23.451709873668655, -46.76633455406208],
    [-23.453146894935216, -46.76647407787007],
    [-23.45547267151323, -46.76657391345817],
    [-23.45745097397038, -46.765919444006045],
    [-23.457474156473904, -46.76705879170353],
    [-23.458350134024258, -46.7669407858058]
  ]
  coordinates.each do |coordinate|
    route2.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  route1.distance = route1.total_distance
  route2.distance = route2.total_distance

  route1.save
  route2.save

  puts "routes created"

  rand(2..5).times do
    route_photo = Unsplash::Photo.random(query: "#{route1.type_of_route} Route")
    if route_photo.present?
      route1.photos.attach(io: URI.open(route_photo.urls.regular), filename: "route_photo.jpg")
      route1.save(validate: false)
    else
      puts "Failed to find a Route photo"
    end
  end

  rand(2..5).times do
    route_photo = Unsplash::Photo.random(query: "#{route2.type_of_route} Route")
    if route_photo.present?
      route2.photos.attach(io: URI.open(route_photo.urls.regular), filename: "route_photo.jpg")
      route2.save(validate: false)
    else
      puts "Failed to find a Route photo"
    end
  end
end
