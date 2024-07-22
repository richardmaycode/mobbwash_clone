class Request < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :vendor, class_name: "User", required: false
  belongs_to :vehicle

  has_many :request_services

  scope :not_today, -> { where("scheduled < ?", Date.today) }
  scope :incomplete, -> { where(completed: nil) }
  scope :unassigned, -> { where(vendor: nil) }

  validates :location, presence: true
  validates :location_lat, presence: true
  validates :location_long, presence: true
  validates :scheduled, presence: true
end
