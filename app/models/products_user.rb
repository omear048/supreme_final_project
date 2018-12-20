class ProductsUser < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :user_id, uniqueness: { scope: :product_id } 
end
