class Fiximage1 < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :image, :image1
    change_column :products, :image1, :string
  end
end
