class Adding < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :subcategory, :string
    add_column :products, :designer, :string
  end
end
