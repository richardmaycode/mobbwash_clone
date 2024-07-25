class Payment < ApplicationRecord
  enum :outcome, { success: 0, failure: 1 }
  belongs_to :user
end
