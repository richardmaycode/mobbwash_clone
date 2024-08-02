class VehicleSize < ApplicationRecord
  has_many :vehicle_categories
  has_many :prices

  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }

  validates :name, presence: true, uniqueness: true
end
