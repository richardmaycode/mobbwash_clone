class Request < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :vendor, class_name: "User", required: false
  belongs_to :vehicle

  has_many :request_services, inverse_of: :request, dependent: :destroy
  has_many :services, through: :request_services, source: :service

  scope :not_today, -> { where("scheduled < ?", Date.today) }
  scope :incomplete, -> { where(completed: nil) }
  scope :unassigned, -> { where(vendor: nil) }

  validates :location, presence: true
  validates :location_lat, presence: true
  validates :location_long, presence: true
  validates :scheduled, presence: true
  validates :access_details, presence: true

  validate :vendor_is_not_customer

  after_create :assign_request_number

  def vendor_is_not_customer
    unless vendor.nil?
      unless vendor.user_type == "vendor"
        errors.add(:vendor, "Vendor cannot be a customer.")
      end
    end
  end

  def assign_request_number
    update_column(:request_number, 13000000 + id)
  end
end
