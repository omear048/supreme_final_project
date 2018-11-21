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



  default_scope -> { order('created_at DESC') }


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
