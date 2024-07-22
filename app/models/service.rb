class Service < ApplicationRecord
  has_many :request_services
  has_many :requests, through: :request_services

  scope :active, -> { where(active: true) }

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
end
