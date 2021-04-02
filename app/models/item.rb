class Item < ApplicationRecord

  belongs_to :buyer, class_name:  'User', foreign_key:  'buyer_id', optional: true # buyer_id won't be set
  belongs_to :seller, class_name:  'User', foreign_key:  'seller_id'               # until someone buyes the item
                                                                                   # hence optional: true
  has_many :item_details
  has_many :images, through: :item_details
  has_many :bulletings, through: :item_details

  accepts_nested_attributes_for :images
  validates :start_time, presence: true
  validate :start_time_must_be_in_futur
  validate :end_time_later_than_start_time


  def start_time_must_be_in_futur
    if start_time
      errors.add(:start_time, "must be in the future!") if start_time&.strftime('%Y-%m-%d %H:%M:%S') < Time.now.strftime('%Y-%m-%d %H:%M:%S')
    end
  end

  def end_time_later_than_start_time
    if start_time && end_time 
      errors.add(:end_time, "must be ahead of start time!") if start_time > end_time
    end
  end
  # validates :title, presence: true
  # validates :starting_price, presence: true, numericality: { only_integer: true }
  # validates :duration, presence: true 
  # validates :shipping, presence: true  
end
 