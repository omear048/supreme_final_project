class Change < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :image, :string
  end
end
