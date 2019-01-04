class UsersAddress < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  validates_uniqueness_of :user_id
  validates :user_id, presence: true #Each purchase must have a user associated with it
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 250 }
  validates :city, presence: true
  validates :state, presence: true 
  validates :zip, presence: true, numericality: true 
  validates :phone, format: { with: /\A[0-9A ()-]*\Z/ }
end
