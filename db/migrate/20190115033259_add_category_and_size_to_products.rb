class AddCategoryAndSizeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :size, :text
    add_column :products, :category, :text
  end
end
