class Service < ApplicationRecord
  has_many :prices
  
  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }

  validates :name, presence: true, uniqueness: true
end
