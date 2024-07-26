class Request < ApplicationRecord
  enum :status, { awaiting_bids: 0, awaiting_payment: 1, assigned: 2, completed: 3, expired: 4, cancelled: 5 }, default: :awaiting_bids
  enum :request_type, { asap: 0, scheduled: 1 }, default: :scheduled

  belongs_to :customer, class_name: "User", required: false
  belongs_to :vendor, class_name: "User", required: false
  belongs_to :vehicle

  has_one :cancellation, required: false

  has_many :request_services, inverse_of: :request, dependent: :destroy
  has_many :services, through: :request_services, source: :service

  scope :not_today, -> { where("scheduled < ?", Date.today) }
  scope :incomplete, -> { where(completed: nil) }
  scope :unassigned, -> { where(vendor: nil) }

  # Base Validations
  validates :location, presence: true
  validates :location_lat, presence: true
  validates :location_long, presence: true
  validates :scheduled, presence: true
  validates :access_details, presence: true
  validate :vendor_is_not_customer
  validates :request_type, presence: true

  # Completion Validations
  validate :completed_date_present, on: :completion
  validate :completed_cannot_be_in_the_future, on: :completion
  validate :completion_status, on: :completion

  after_create :assign_request_number

  def google_map_url
    "https://maps.google.com/?q=#{location_lat},#{location_long}"
  end

  def completable_state?
    status == "assigned"
  end

  def completed_date_present
    if !completed.present?
      errors.add(:completed, "must be a valid date")
    end
  end

  def completion_status
    if status != "completed"
      errors.add(:status, "must be completed when completion is finished")
    end
  end

  def completed_cannot_be_in_the_future
    if completed.present? && completed > Date.today
      errors.add(:completed, "can't be in the future")
    end
  end

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

# TODO: Create ability for customer to cancel request
