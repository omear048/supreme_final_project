class DeleteUnnecessaryFieldsFromItemsOrders < ActiveRecord::Migration[5.2]
   def change 
    remove_column :items_orders, :user_id, :integer
    remove_column :items_orders, :purchase_id, :integer
  end
end
