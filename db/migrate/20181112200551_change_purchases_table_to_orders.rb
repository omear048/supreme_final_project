class ChangePurchasesTableToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_table :purchases, :orders 
  end

  def change
    rename_table :products_purchases, :items_orders
  end
end
