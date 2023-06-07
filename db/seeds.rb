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
Route.destroy_all
User.destroy_all


user1 = User.create!(email: "joao@gmail.com", password: "123123")
user2 = User.create!(email: "paulo@gmail.com", password: "123123")
user3 = User.create!(email: "alphadeny@hotmail.fr", password: "123123")
user4 = User.create!(email: "thiago@olatu.com", password: "123123")
user5 = User.create!(email: "juliavdheyde@icloud.com", password: "123123")


route1 = Route.create!(
  name: "Rota Parque do Ibirapuera",
  description: "Trilha muito tranquilha ao redor do Parque",
  type_of_route: "Urbano",
  positive_elevation: 1.5,
  creator: user1
)

route2 = Route.create!(
  name: "Rota Nervosa Pico do Jaragua",
  description: "Trilha hardcore",
  type_of_route: "Montanha",
  positive_elevation: 4.9,
  creator: user2
)

route3 = Route.create!(
  name: "Rota Imigrantes",
  description: "trilha na descida da serra da Imigrantes",
  type_of_route: "Montanha",
  positive_elevation: 4.9,
  creator: user3
)

route4 = Route.create!(
  name: "Rota Itamambuca",
  description: "trilha maravilhosa para a praia de Itamambuca",
  type_of_route: "Praia",
  positive_elevation: 3.2,
  creator: user4
)

route5 = Route.create!(
  name: "Rota Centro de SP",
  description: "passeio pelo pontos históricos no centro da cidade",
  type_of_route: "Urbano",
  positive_elevation: 2.9,
  creator: user5
)
