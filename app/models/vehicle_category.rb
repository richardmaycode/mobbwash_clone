class VehicleCategory < ApplicationRecord
  belongs_to :vehicle_size
  has_many :prices

  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }

  validates :name, presence: true, uniqueness: true
end
