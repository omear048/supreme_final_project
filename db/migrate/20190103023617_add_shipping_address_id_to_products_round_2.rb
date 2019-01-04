class AddShippingAddressIdToProductsRound2 < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :purchaser_shipping_address_id, :integer 
  end
end
