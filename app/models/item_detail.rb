class ItemDetail < ApplicationRecord
  belongs_to :item
  belongs_to :image, optional: true 
  belongs_to :bulleting, optional: true
end