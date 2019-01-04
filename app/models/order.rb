class Order < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true 
  has_many :items_orders, dependent: :destroy 
end
