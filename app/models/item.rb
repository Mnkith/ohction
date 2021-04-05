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

  accepts_nested_attributes_for :images, reject_if: proc {|attributes| attributes[:path].blank?}
  accepts_nested_attributes_for :bulletings, reject_if: proc {|attributes| attributes[:bulleting].blank?}
  accepts_nested_attributes_for :bids

  validates :start_time, presence: true
  validate :start_time_must_be_in_futur, on: :create
  validate :end_time_later_than_start_time, on: :create

  def start_time_must_be_in_futur
    if start_time && (Item.dezone(start_time) < Item.dezone(Time.now))
      errors.add(:start_time,
                 'must be in the future!')
    end
  end

  def end_time_later_than_start_time
    errors.add(:end_time, 'must be ahead of start time!') if start_time && end_time && (start_time > end_time)
  end
  # validates :title, presence: true
  # validates :starting_price, presence: true, numericality: { only_integer: true }
  # validates :duration, presence: true
  # validates :shipping, presence: true

  # def upload_images(item, paths)
  #   paths.each do |_, _v|
  #     uploaded_file = [:path]
  #     File.open(Rails.root.join('app', 'assets', 'images', uploaded_file.original_filename), 'wb') do |file|
  #       file.write(uploaded_file.read)
  #     end
  #     item.images << Image.create(path: uploaded_file.original_filename)
  #   end
  # end

  # def self.dezone time
  #   time.strftime('%Y-%m-%d %H:%M:%S')
  # end

  # def status_based_display current_user
  #   if owner? current_user
  #     content_tag :li, 'You own this item', class:"list-group-item"
  #   end

  # end
end
