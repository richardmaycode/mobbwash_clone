class Service < ApplicationRecord
  has_many :request_services
  has_many :requests, through: :request_services

  scope :active, -> { where(active: true) }

  validates :name, presence: true, uniqueness: true
  validates :min_price, presence: true
  validates :max_price, presence: true
  validates :avg_price, presence: true
end
