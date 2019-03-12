class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products
  validates :category, presence: true
  validates_uniqueness_of :subcategory
end
