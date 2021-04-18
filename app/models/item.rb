class Item < ApplicationRecord
  extend ItemsHelper::ClassHelper
  include ItemsHelper::InstanceHelper
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true # buyer_id won't be set
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'               # until someone buyes the item
  # hence optional: true
  has_many :bids
  has_many :users, through: :bids
  has_many :item_details
  has_many :images, through: :item_details
  has_many :bulletings, through: :item_details

  accepts_nested_attributes_for :images, reject_if: proc {|attributes| attributes[:path].blank?}, allow_destroy: true
  accepts_nested_attributes_for :bulletings, reject_if: proc {|attributes| attributes[:bulleting].blank?}, allow_destroy: true
  accepts_nested_attributes_for :bids

  validates :start_time, presence: true
  validates :status, inclusion: { in: %w(pending active sold failed), message: "%{attribute} is not a valid status" }
  validate :start_time_must_be_in_futur, on: :create
  validate :end_time_later_than_start_time, on: :create

  scope :filter_by_status, -> (status) { where status: status }

  # scope :active(status), -> { where(active?: true) }

  def start_time_must_be_in_futur
    if start_time && (Item.dezone(start_time) < Item.dezone(Time.now))
      errors.add(:start_time,
                 'must be in the future!')
    end
  end

  # def status 
  #   update_status
  # end


  def end_time_later_than_start_time
    errors.add(:end_time, 'must be ahead of start time!') if start_time && end_time && (start_time > end_time)
  end

  def instanciate_nested_attributes
    5.times do 
      self.images << Image.new
      self.bulletings << Bulleting.new
    end 
  end

  def set_sold
    self.images.clear
    self.images << Image.find_or_create_by(path: 'sold.jpg')
    self.buyer_id = Bid.last.user_id
    # self.save
  end

  def update_status
    if active?
      self.update status: 'active'
    elsif sold?
      set_sold
      self.update status: 'sold'
    elsif failed?
      self.update status: 'failed'
    end
  end
end
