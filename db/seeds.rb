# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Service.create! name: "Basic Interior", price: 45.50, active: true
Service.create! name: "Basic Interior/Exterior", price: 65.50, active: true
Service.create! name: "Interior/Exterior with Wax", price: 85.50, active: true
Service.create! name: "Custom", price: 150.00, active: true

User.create! name: "Richard Wise", email: "richard.wise@hey.com", password_digest: "Test123", user_type: 2
User.create! name: "Jerrys Wash Shop", email: "Test@gmail.com", password_digest: "Test123", user_type: 1
Vehicle.create! nickname: "Noble Stead", make: "Chevy", model: "Bolt EUV", color: "Gray", license_plate: "TTT-X12", user_id: 1, default: true
Vehicle.create! nickname: "Roach", make: "Tesla", model: "Model Y", color: "Red", license_plate: "XAX-776", user_id: 1, default: false

Request.create! access_details: "test", location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now - 5.days, completed: Time.zone.now - 5.days, customer_id: 1, vehicle_id: 1, status: "completed"
Request.create! access_details: "test", location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now - 1.days, customer_id: 1, vehicle_id: 1, status: "expired"
150.times do
  Request.create! access_details: "test", location: Faker::Address.full_address, location_lat: Faker::Address.latitude, location_long: Faker::Address.longitude, scheduled: Time.zone.now, customer_id: 1, vehicle_id: 1
end

count = 0

152.times do
  count += 1
  RequestService.create! request_id: count, service_id: rand(1..4)
end
