class Bid < ApplicationRecord
  enum :status, { active: 0, accepted: 1, cancelled: 2, declinded: 3 }, default: 0

  belongs_to :request
  belongs_to :vendor, class_name: "User", required: false
  has_one :customer, through: :request

  validates :amount, presence: true, numericality: true
  validates :work_date, presence: true

  validate :work_date_on_or_after_requested_date

  def work_date_on_or_after_requested_date
    if work_date < request.scheduled
      errors.add(:work_date, "must be on or after the customers requested appointed time")
    end
  end
end
