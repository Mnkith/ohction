class ItemDetail < ApplicationRecord
  belongs_to :item
  belongs_to :image, optional: true 
  belongs_to :bulleting, optional: true

  validate :start_time_must_be_in_futur


  def start_time_must_be_in_futur
    errors.add(:start_time, "must be in the future!") if Time.parse(:start_time) < Time.now
  end
end