class User < ApplicationRecord

  has_many :purchases, class_name: 'Item', foreign_key:  'buyer_id'
  has_many :sales, class_name: 'Item', foreign_key:  'seller_id'

  has_many :bids
  has_many :items, through: :bids

  has_secure_password #validations: false #suppress default validations

  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # validates :password, presence: true#, length: { minimum: 6 }
end
