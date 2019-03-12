class Product < ApplicationRecord
  #default_scope -> { order('created_at DESC') }

  has_one_attached :product_image_1
  has_one_attached :product_image_2
  has_one_attached :product_image_3

  belongs_to :user
  belongs_to :users_address, optional: true

  has_many :products_users, dependent: :destroy
  has_one :items_orders

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: true , numericality: { greater_than: 0 }
  validates :category, presence: true 
  validates :subcategory, presence: true 
  validates :size, presence: true 

  scope :product_size, -> (size) { where size: size }
  scope :product_category, -> (category) { where category: category }
end

