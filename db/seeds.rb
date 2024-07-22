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
Vehicle.create! nickname: "Noble Stead", make: "Chevy", model: "Bolt EUV", color: "Gray", license_plate: "TTT-X12", user_id: 1

Request.create! location: "Test", location_lat: 25.4, location_long: 26.2, scheduled: Time.zone.now - 5.days, completed: Time.zone.now - 5.days, customer_id: 1, vehicle_id: 1
Request.create! location: "Test", location_lat: 25.4, location_long: 26.2, scheduled: Time.zone.now - 1.days, customer_id: 1, vehicle_id: 1
150.times do
  Request.create! location: "Test", location_lat: 25.4, location_long: 26.2, scheduled: Time.zone.now, customer_id: 1, vehicle_id: 1
end

RequestService.create! request_id: 1, service_id: 1
