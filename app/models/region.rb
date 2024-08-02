class Region < ApplicationRecord
  has_many :users

  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }

  validates :name, presence: true, uniqueness: true
end
