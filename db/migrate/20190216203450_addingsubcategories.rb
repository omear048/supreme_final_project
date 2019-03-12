class Addingsubcategories < ActiveRecord::Migration[5.2]
  def up
    Subcategory.create(subcategory: "Long Sleeve T-Shirts", category_id: 1);
    Subcategory.create(subcategory: "Polos", category_id: 1);
    Subcategory.create(subcategory: "Short Sleeve T-Shirt", category_id: 1);
    Subcategory.create(subcategory: "Sweaters & Knitwhere", category_id: 1);
    Subcategory.create(subcategory: "Sweatshirts & Hoodies", category_id: 1);
    Subcategory.create(subcategory: "Tank Tops & Shortsleeves", category_id: 1);
    Subcategory.create(subcategory: "Jerseys", category_id: 1);
    
    Subcategory.create(subcategory: "Casual Pants", category_id: 2);
    Subcategory.create(subcategory: "Cropped Pants", category_id: 2);
    Subcategory.create(subcategory: "Denim", category_id: 2);
    Subcategory.create(subcategory: "Leggings", category_id: 2);
    Subcategory.create(subcategory: "Overalls & Jumpsuits", category_id: 2);
    Subcategory.create(subcategory: "Shorts", category_id: 2);
    Subcategory.create(subcategory: "Sweatpants & Joggers", category_id: 2);
    Subcategory.create(subcategory: "Swimwear", category_id: 2);

    Subcategory.create(subcategory: "Bombers", category_id: 3);
    Subcategory.create(subcategory: "Cloaks & Capes", category_id: 3);
    Subcategory.create(subcategory: "Denim Jackets", category_id: 3);
    Subcategory.create(subcategory: "Heavy Coats", category_id: 3);
    Subcategory.create(subcategory: "Leather Jackets", category_id: 3);
    Subcategory.create(subcategory: "Light Jackets", category_id: 3);
    Subcategory.create(subcategory: "Parkas", category_id: 3);
    Subcategory.create(subcategory: "Raincoats", category_id: 3);
    Subcategory.create(subcategory: "Vests", category_id: 3);

    Subcategory.create(subcategory: "Boots", category_id: 4);
    Subcategory.create(subcategory: "Casual Leather Shoes", category_id: 4);
    Subcategory.create(subcategory: "Formal Shoes", category_id: 4);
    Subcategory.create(subcategory: "Hi-Top Sneakers", category_id: 4);
    Subcategory.create(subcategory: "Low-Top Sneakers", category_id: 4);
    Subcategory.create(subcategory: "Sandals", category_id: 4);
    Subcategory.create(subcategory: "Slip Ons", category_id: 4);

    Subcategory.create(subcategory: "Blazers", category_id: 5);
    Subcategory.create(subcategory: "Fromal Shirting", category_id: 5);
    Subcategory.create(subcategory: "Formal Trousers", category_id: 5);
    Subcategory.create(subcategory: "Suits", category_id: 5);
    Subcategory.create(subcategory: "Tuxedos", category_id: 5);
    Subcategory.create(subcategory: "Vests", category_id: 5);
    
    Subcategory.create(subcategory: "Bags & Luggage", category_id: 6);
    Subcategory.create(subcategory: "Belts", category_id: 6);
    Subcategory.create(subcategory: "Glasses", category_id: 6);
    Subcategory.create(subcategory: "Gloves & Scarves", category_id: 6);
    Subcategory.create(subcategory: "Hats", category_id: 6);
    Subcategory.create(subcategory: "Jewlery & Watches", category_id: 6);
    Subcategory.create(subcategory: "Wallets", category_id: 6);
    Subcategory.create(subcategory: "Miscellaneous", category_id: 6);
    Subcategory.create(subcategory: "Periodicals", category_id: 6);
    Subcategory.create(subcategory: "Socks & Underwear", category_id: 6);
    Subcategory.create(subcategory: "Sunglasses", category_id: 6);
    Subcategory.create(subcategory: "Supreme", category_id: 6);
    Subcategory.create(subcategory: "Bape", category_id: 6);
    Subcategory.create(subcategory: "Ties & Pocketsquares", category_id: 6);
  end

  def down
  end
end
