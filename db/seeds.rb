
VehicleSize.create! name: "Economy", active: true
VehicleSize.create! name: "Medsize", active: true
VehicleSize.create! name: "Luxury", active: true

VehicleCategory.create! name: "Economy Car", active: true, vehicle_size_id: 1
VehicleCategory.create! name: "Economy Truck", active: true, vehicle_size_id: 1
VehicleCategory.create! name: "Small Boat/Trailer < 20'", active: true, vehicle_size_id: 1
VehicleCategory.create! name: "Motorcycle", active: true, vehicle_size_id: 2
VehicleCategory.create! name: "Medsize Sedan", active: true, vehicle_size_id: 2
VehicleCategory.create! name: "Medsize Truck", active: true, vehicle_size_id: 2
VehicleCategory.create! name: "Minivan", active: true, vehicle_size_id: 2
VehicleCategory.create! name: "boat/trailer 21' to 27'", active: true, vehicle_size_id: 2
VehicleCategory.create! name: "Touring Motorcycle", active: true, vehicle_size_id: 3
VehicleCategory.create! name: "Luxury Car", active: true, vehicle_size_id: 3
VehicleCategory.create! name: "Super Duty Truck", active: true, vehicle_size_id: 3
VehicleCategory.create! name: "Cargo Van", active: true, vehicle_size_id: 3
VehicleCategory.create! name: "Luxury Boat/Trailer Less Than 32'", active: true, vehicle_size_id: 3

Service.create! name: "Exterior Wash", active: true
Service.create! name: "Interior/Exterior Wash", active: true
Service.create! name: "Showroom Detail w/Wax", active: true
Service.create! name: "Custom/ Dealer Service", active: true

Region.create! name: "South Florida", active: true, center_lat: 26.12, center_long: -80.14

# DEFAULT PRICING
# ECONOMY
Price.create! amount: 6000, vehicle_size_id: 1, service_id: 1, region_id: 1
Price.create! amount: 8000, vehicle_size_id: 2, service_id: 1, region_id: 1
Price.create! amount: 12000, vehicle_size_id: 3, service_id: 1, region_id: 1

# MIDSIZE
Price.create! amount: 10000, vehicle_size_id: 1, service_id: 2, region_id: 1
Price.create! amount: 12000, vehicle_size_id: 2, service_id: 2, region_id: 1
Price.create! amount: 15000, vehicle_size_id: 3, service_id: 2, region_id: 1

# LUXURY
Price.create! amount: 15000, vehicle_size_id: 1, service_id: 3, region_id: 1
Price.create! amount: 18000, vehicle_size_id: 2, service_id: 3, region_id: 1
Price.create! amount: 30000, vehicle_size_id: 3, service_id: 3, region_id: 1




User.create! name: "Richard Wise", email: "admin@test.com", password: "password", user_type: 0, address_line_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, postal_code: Faker::Address.postcode, phone_number: Faker::PhoneNumber.phone_number, region_id: 1
User.create! name: "Jerrys Mobile Carwash", email: "vendor@test.com", password: "password", user_type: 1, address_line_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, postal_code: Faker::Address.postcode, phone_number: Faker::PhoneNumber.phone_number, region_id: 1
User.create! name: "Richard Wise", email: "customer@test.com", password: "password", user_type: 2, address_line_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, postal_code: Faker::Address.postcode, phone_number: Faker::PhoneNumber.phone_number, region_id: 1
Vehicle.create! nickname: "test", make: "test", model: Faker::Vehicle.model, color: Faker::Vehicle.color, license_plate: Faker::Vehicle.license_plate, user_id: 3, default: true




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
