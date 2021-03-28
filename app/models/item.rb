class Item < ApplicationRecord

  belongs_to :buyer, class_name:  'User', foreign_key:  'buyer_id', optional: true # buyer_id won't be set
  belongs_to :seller, class_name:  'User', foreign_key:  'seller_id'               # until someone buyes the item
                                                                                   # hence optional: true

end
 