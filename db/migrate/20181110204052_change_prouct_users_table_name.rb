class ChangeProuctUsersTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_purchases, :products_purchases
  end
end
