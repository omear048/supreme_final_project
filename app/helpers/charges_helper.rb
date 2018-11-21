module ChargesHelper
=begin
    @user = current_user
  @items = ProductsUser.all
  @products = Product.all

  def user_total 
    total = 0

    @items.each do |item|
      if item.user_id == @user.id 
        @products.each do |product_match|
          if product_match.id == item.product_id
            price = product_match.price
            if product_match.price.nil?
              price = 0
            end
            total += 0
          end
        end
      end
    end
  end

  total

=end
end
