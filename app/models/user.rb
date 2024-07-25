class User < ApplicationRecord
  has_secure_password

  PASSWORD_MIN_LENGTH = 8
  PASSWORD_MAX_LENGTH = 84

  enum :user_type, { admin: 0, vendor: 1, customer: 2 }

  has_many :vehicles
  has_many :requests, foreign_key: "customer_id"
  has_many :assigned_requests, foreign_key: "vendor_id", class_name: "Request"
  has_many :cancellations, foreign_key: "vendor_id", class_name: "Cancellation"
  has_many :payments

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :email, presence: true, uniqueness: true

  validates_length_of :password, allow_blank: true, minimum: PASSWORD_MIN_LENGTH, maximum: PASSWORD_MAX_LENGTH, on: [ :create, :update ]
  validates_confirmation_of :password, allow_blank: true, on: :update

  validates :address_line_1, :city, :state, :postal_code, :phone_number, presence: true, on: :update

  def role_portal
    case user_type
    when "admin"
      admin_users_path
    when "vendor"
      vendor_dashoard_path
    when "customer"
      Rails.application.routes.url_helpers.customer_requests_path(self)
    end
  end

  def customer_profile_incomplete?
    true if missing_vehicle? || contact_info_incomplete?
  end

  def missing_vehicle?
    vehicles.empty?
  end

  def contact_info_incomplete?
    postal_code.empty?
  end
end
