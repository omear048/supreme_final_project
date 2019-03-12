class ChangeSubcategoriesCategoryItToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :subcategories, :category_id, :integer
  end
end
