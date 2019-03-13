class AddingItemsForSaleSoHomePageWillLoad < ActiveRecord::Migration[5.2]
  def change
    User.create(email: "dick@gmail.com", password: "password", name: "Nolan", phone: "612-247-3127" )


    Subcategory.create(subcategory: "Long Sleeve T-Shirts", category_id: 1);
   
    Product.create(title: "item 1", price: 1200, user_id: 1, size: "M", category: "Footwear", subcategory: "Hi-Top Sneakers", designer: "Gucci", description: "N/A")
    Product.create(title: "item 2", price: 1200, user_id: 1, size: "M", category: "Footwear", subcategory: "Hi-Top Sneakers", designer: "Gucci", description: "N/A")
    Product.create(title: "item 3", price: 1200, user_id: 1, size: "M", category: "Footwear", subcategory: "Hi-Top Sneakers", designer: "Gucci", description: "N/A")
    Product.create(title: "item 4", price: 1200, user_id: 1, size: "M", category: "Footwear", subcategory: "Hi-Top Sneakers", designer: "Gucci", description: "N/A")
  end
end
