# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Customer.create(first_name: "Luis", last_name: "Aparicio", email: "Luis@email.com", address: "12907 conquistador loop dr, Tampa, Florida, 34610")
Tea.create(title: "Black Tea", description: "bold and brisk", temperature: 212, brew_time: 3.5)
Tea.create(title: "Green Tea", description: "grassy flavor", temperature: 175, brew_time: 2)
Tea.create(title: "Oolong Tea", description: "floral aroma", temperature: 185, brew_time: 5)