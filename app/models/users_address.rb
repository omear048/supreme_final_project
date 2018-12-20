class UsersAddress < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id
  validates :user_id, presence: true #Each purchase must have a user associated with it
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 250 }
  validates :city, presence: true
  validates :state, presence: true 
  validates :zip, presence: true, numericality: true 
end
