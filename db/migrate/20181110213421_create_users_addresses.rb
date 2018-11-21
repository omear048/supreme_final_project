class CreateUsersAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :users_addresses do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone

      t.timestamps
    end
  end
end
