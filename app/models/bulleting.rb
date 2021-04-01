class Bulleting < ApplicationRecord
  has_one :item_detail
  has_one :item
end
