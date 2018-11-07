class UpdateSoldOfExistingProducts < ActiveRecord::Migration[5.2]
  def up
    Product.update_all({ :sold => false })
    change_column :products, :sold, :boolean, default: false
  end

end
