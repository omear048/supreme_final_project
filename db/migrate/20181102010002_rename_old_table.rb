class RenameOldTable < ActiveRecord::Migration[5.2]
  def change
      rename_table :products_carts, :products_users
  end
end
