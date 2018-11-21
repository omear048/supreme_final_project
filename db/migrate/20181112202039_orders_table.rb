class OrdersTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :purchases, :orders 
  end
end
