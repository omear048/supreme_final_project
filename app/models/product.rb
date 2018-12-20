class Product < ApplicationRecord
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  has_many :products_users, dependent: :destroy
  has_one :items_orders
  validates :user_id, presence: true #Each product has an associated user_id 
  validates :title, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: true , numericality: { greater_than: 0 }
  validates :picture_url, presence: true
 
  

  def self.search(search)
    available_items = Product.where(sold: false)

    if search 
      product = available_items.where("title like ?", "%#{search}%")
    else
      available_items
    end
  end
end
