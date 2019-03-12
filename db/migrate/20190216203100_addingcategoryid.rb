class Addingcategoryid < ActiveRecord::Migration[5.2]
  def change
    add_column :subcategories, :category_id, :number
  end
end
