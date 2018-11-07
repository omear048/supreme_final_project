class ProductsUser < ApplicationRecord
  validates :user_id, uniqueness: { scope: :product_id } 
  #validates_uniqueness_of :product_id, :user_id, #:message => "Product already added to your cart."

end
