class User < ApplicationRecord
  has_secure_password

  PASSWORD_MIN_LENGTH = 8
  PASSWORD_MAX_LENGTH = 84

  enum :user_type, { admin: 0, vendor: 1, customer: 2 }

  has_many :vehicles
  has_many :requests, foreign_key: "customer_id"
  has_many :assigned_requests, foreign_key: "vendor_id", class_name: "Request"
  has_many :cancellations, foreign_key: "vendor_id", class_name: "Cancellation"

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :email, presence: true, uniqueness: true

  validates_length_of :password, allow_blank: true, minimum: PASSWORD_MIN_LENGTH, maximum: PASSWORD_MAX_LENGTH, on: [ :create, :update ]
  validates_confirmation_of :password, allow_blank: true, on: :update

  def assigned_portal
    case user_type
    when "admin"
      admin_users_path
    when "vendor"
      vendor_dashoard_path
    when "customer"
      customer_requests_path
    end
  end
end
