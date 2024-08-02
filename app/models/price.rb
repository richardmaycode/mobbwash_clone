class Price < ApplicationRecord
  enum :status, { created: 0, active: 1, inactive: 2 }, validate: true, default: 0

  belongs_to :vehicle_size
  belongs_to :service
  belongs_to :region
end
