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

  def merged_name
    [ make, model, color ].join(" | ")
  end

  def default?
    default == true
  end
end
