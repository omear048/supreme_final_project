class Product < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true #Each product has an associated user_id 
 
  def self.search(search)
    available_items = Product.where(sold: false)

    if search 
      product = available_items.where("title like ?", "%#{search}%")
    else
      available_items
    end
  end
end
