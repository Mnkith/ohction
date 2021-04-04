class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
