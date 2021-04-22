class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  before_save :update_item


  validates :amount, numericality: { greater_than: 0 }

  def update_item
    item = self.item
    item.current_price += amount
    item.update_status
    item.save
  end
end
