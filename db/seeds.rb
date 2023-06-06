# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'unsplash'

Ride.destroy_all
Route.destroy_all
Favorite.destroy_all
User.destroy_all

User.create!(first_name: "Joao", last_name: "De la Vegas", email: "joao@gmail.com", password: "123123")
User.create!(first_name: "Paulo", last_name: "De la Bamba", email: "paulo@gmail.com", password: "123123")
User.create!(first_name: "Alphonse", last_name: "Black Mamba", email: "alphadeny@hotmail.fr", password: "123123")
User.create!(first_name: "Thiago", last_name: "Cucaracha", email: "thiago@olatu.com", password: "123123")
User.create!(first_name: "Julia", last_name: "Senhorita", email: "juliavdheyde@icloud.com", password: "123123")
