class Vehicle < ApplicationRecord
  belongs_to :user

  validates :nickname, presence: true
  validates :make, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :license_plate, presence: true
end
