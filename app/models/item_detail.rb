class ItemDetail < ApplicationRecord
  belongs_to :item
  belongs_to :image 
  # belongs_to :bulleting
end