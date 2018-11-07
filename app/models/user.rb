class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products, dependent: :destroy #product destroyed if the user is destroyed
  has_many :products_users, dependent: :destroy
  default_scope -> { order('created_at DESC') }


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
