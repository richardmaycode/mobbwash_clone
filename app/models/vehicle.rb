class Vehicle < ApplicationRecord
  COLORS = %w[red orange yellow green blue violet black white gray beige]
  MAKES = %w[BMW AUDI Toyota Chevy Ford Dodge Lincoln Buick Honda Nissan Tesla Rivian]
  MODELS = %w[Test]

  belongs_to :user
  has_many :requests

  validates :nickname, presence: true
  validates :make, presence: true
  validates :model, presence: true
  validates :color, presence: true

  after_create :assign_new_and_sole_as_default

  def merged_name
    [ make, model, color ].join(" | ")
  end

  def default?
    default == true
  end

  def assign_new_and_sole_as_default
    update_column(:default, true) if user.vehicles.count == 1
  end
end
