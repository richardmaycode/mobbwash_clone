class Cancellation < ApplicationRecord
  CANCELLATION_REASONS = {
    "Missing": "Unable to find Vehicle",
    "Malfuction": "Mobile Cleaner Malfuction",
    "Location": "Location not suitable for cleaning",
    "Scheduling": "Scheduling Conflict"
  }

  belongs_to :vendor, class_name: "User", required: true
  belongs_to :request

  validates :reported, presence: true
  validates :notes, presence: true, length: { in: 10..100 }
end
