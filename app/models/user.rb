class User < ApplicationRecord
  has_many :products, dependent: :destroy 
  has_many :products_users, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :users_address, dependent: :destroy 

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }

  default_scope -> { order('created_at DESC') }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
