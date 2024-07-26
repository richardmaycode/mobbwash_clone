class Service < ApplicationRecord
  has_many :request_services
  has_many :requests, through: :request_services

  scope :active, -> { where(active: true) }

  validates :name, presence: true, uniqueness: true
  validates :min_price, presence: true, numericality: true
  validates :max_price, presence: true, numericality: true
  validates :avg_price, presence: true, numericality: true

  validate :avg_price_is_above_max_price
  validate :avg_price_is_below_min_price
  validate :max_price_is_above_min_price
  validate :min_price_is_below_max_price

  def avg_price_is_below_min_price
    if avg_price < min_price
      errors.add(:avg_price, "can't be less than the min price")
    end
  end

  def avg_price_is_above_max_price
    if avg_price > max_price
      errors.add(:avg_price, "can't be more than the max price")
    end
  end

  def max_price_is_above_min_price
    if max_price < min_price
      errors.add(:max_price, "can't be less than the min price")
    end
  end


  def min_price_is_below_max_price
    if min_price > max_price
      errors.add(:min_price, "can't be more than the avg price")
    end
  end
end
