class Image < ApplicationRecord

end
class Image < ApplicationRecord
  has_one :item_detail
  has_one :item 
end
