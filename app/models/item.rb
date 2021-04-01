class Item < ApplicationRecord

  belongs_to :buyer, class_name:  'User', foreign_key:  'buyer_id', optional: true # buyer_id won't be set
  belongs_to :seller, class_name:  'User', foreign_key:  'seller_id'               # until someone buyes the item
                                                                                   # hence optional: true
  has_many :item_details
  has_many :images, through: :item_details
  # has_many :bulletings, through: :item_datails

  # validates :title, presence: true
  # validates :starting_price, presence: true, numericality: { only_integer: true }
  # validates :duration, presence: true 
  # validates :shipping, presence: true  
end
 