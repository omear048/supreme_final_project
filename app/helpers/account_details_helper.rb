module AccountDetailsHelper
  def product_name(product_id)
    Product.find(product_id).title
  end

  def product_price(product_id)
    Product.find(product_id).price
  end

end
