class For < ActiveRecord::Migration[5.2]
  def up
    Category.create(category: "Tops");
    Category.create(category: "Bottoms");
    Category.create(category: "Outerwear");
    Category.create(category: "Footwear");
    Category.create(category: "Tailoring");
    Category.create(category: "Accessories");
  end
  def down
  end
end
