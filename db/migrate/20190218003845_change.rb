class Change < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :image, :image1
  end
end
