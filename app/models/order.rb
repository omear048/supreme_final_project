class Order < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true #Each purchase must have a user associated with it

  has_many :items_orders #each purchase_id can be assocaited with many product_purchases 
end
