#Active record association - Rails Guide
#The table with the Primary Key is the belongs to 
#has_one and belongs_to -> belongs to singular
#has_many -> belongs to plural

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :products, dependent: :destroy #product destroyed if the user is destroyed
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
