class Product < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true #Each product has an associated user_id 

  has_many :products_users, dependent: :destroy
 
end
