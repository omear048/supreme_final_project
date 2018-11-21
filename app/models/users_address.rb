class UsersAddress < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true #Each purchase must have a user associated with it
 
end
