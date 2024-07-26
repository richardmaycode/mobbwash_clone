# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Service.create! name: "Basic Interior", min_price: 60.00, max_price: 95.00, avg_price: 80.12, active: true
Service.create! name: "Basic Interior/Exterior", min_price: 100.00, max_price: 135.00, avg_price: 120.62, active: true
Service.create! name: "Interior/Exterior with Wax", min_price: 140.00, max_price: 185.00, avg_price: 163, active: true
Service.create! name: "Custom", min_price: 1000.00, max_price: 3000.00, avg_price: 2000.00, active: false

# Fake Customers
# if Rails.env.development?
#   100.times do
#     User.create! name: Faker::Name.name, email: Faker::Internet.email, password_digest: Faker::Crypto.md5, user_type: 2, address_line_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, postal_code: Faker::Address.postcode, phone_number: Faker::PhoneNumber.phone_number
#   end

#   25.times do
#     company_name = Faker::Company.name + " " + Faker::Company.suffix
#     User.create! name: company_name, email: Faker::Internet.email, password_digest: Faker::Crypto.md5, user_type: 1, address_line_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, postal_code: Faker::Address.postcode, phone_number: Faker::PhoneNumber.phone_number
#   end

#   User.create! name: "Jerrys Wash Shop", email: "Test@gmail.com", password_digest: "Test123", user_type: 1, address_line_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, postal_code: Faker::Address.postcode, phone_number: Faker::PhoneNumber.phone_number

#   user_count = 1

#   100.times do
#     vehicle_1 = Faker::Vehicle.make
#     vehicle_2 = Faker::Vehicle.make

#     Vehicle.create! nickname: Faker::Hipster.words, make: vehicle_1, model: Faker::Vehicle.model(make_of_model: vehicle_1), color: Faker::Vehicle.color, license_plate: Faker::Vehicle.license_plate, user_id: user_count, default: true
#     Vehicle.create! nickname: Faker::Hipster.words, make: vehicle_2, model: Faker::Vehicle.model(make_of_model: vehicle_2), color: Faker::Vehicle.color, license_plate: Faker::Vehicle.license_plate, user_id: user_count, default: false

#     user_count += 1
#   end

#   Request.create! access_details: "test", location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now - 5.days, completed: Time.zone.now - 5.days, customer_id: 1, vehicle_id: 1, status: "completed"
#   Request.create! access_details: "test", location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now - 1.days, customer_id: 1, vehicle_id: 1, status: "expired"

#   # Fake Available Jobs
#   1000.times do
#     user_id = rand(1..100)
#     Request.create! access_details: Faker::Lorem.sentence(word_count: rand(10..20)), location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now + rand(0..4).days, customer_id: user_id, vehicle_id: User.find(user_id).vehicles.sample.id, status: "available"
#   end

#   # Fake Completed Jobs
#   1000.times do
#     days_ago = rand(4..25)
#     user_id = rand(1..100)
#     Request.create! access_details: Faker::Lorem.sentence(word_count: rand(10..20)), location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now - days_ago.days, completed: Time.zone.now - days_ago.days, customer_id: user_id, vehicle_id: User.find(user_id).vehicles.sample.id, vendor_id: rand(101..126), status: "completed"
#   end

#   # Fake Assigned Jobs
#   1000.times do
#     user_id = rand(1..100)
#     Request.create! access_details: Faker::Lorem.sentence(word_count: rand(10..20)), location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now + rand(0..4).days, customer_id: user_id, vehicle_id: User.find(user_id).vehicles.sample.id, vendor_id: rand(101..126), status: "assigned"
#   end

#   request_count = 0

#   3000.times do
#     request_count += 1
#     RequestService.create! request_id: request_count, service_id: rand(1..4)
#   end

# end
