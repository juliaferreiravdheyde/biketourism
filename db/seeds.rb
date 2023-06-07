# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# require 'open-uri'
# require 'unsplash'

Point.destroy_all
Ride.destroy_all
Favorite.destroy_all
Route.destroy_all
User.destroy_all

User.create!(email: "joao@gmail.com", password: "123123")
User.create!(email: "paulo@gmail.com", password: "123123")
User.create!(email: "alphadeny@hotmail.fr", password: "123123")
User.create!(email: "thiago@olatu.com", password: "123123")
User.create!(email: "juliavdheyde@icloud.com", password: "123123")


