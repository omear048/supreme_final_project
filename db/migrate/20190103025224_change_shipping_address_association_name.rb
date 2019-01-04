class ChangeShippingAddressAssociationName < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :purchaser_shipping_address_id, :users_address_id
  end
end
