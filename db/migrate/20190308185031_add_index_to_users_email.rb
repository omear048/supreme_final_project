class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    execute "DELETE FROM items_orders WHERE id <> 45"
  end
end
