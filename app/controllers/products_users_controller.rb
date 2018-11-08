#Command K = Gets rid of left Menu and Command B brings it back
class ProductsUsersController < ApplicationController
 


  #Adding product to shopping cart (On Shopping Page)
  def create
    #@none = current_user.products.build(products_user_params)
    #@none = Product.new(products_user_params)

    @add_product = ProductsUser.new(products_user_params)
    if @add_product.save
      redirect_to root_url
    else
      nil
    end
  end

  #Users shopping cart
  def cart
    @user = current_user
    @items = ProductsUser.all
    @products = Product.all
  end

  def checkout

  end

  #Delete item from shopping cart
  def destroy
    #binding.pry
    ProductsUser.find_by(product_id: params[:product_id]).destroy

    flash[:success] = "User Deleted"

    redirect_to users_cart_path
  end

  private

    def products_user_params
      params.require(:products_user).permit(:user_id, :product_id)
    end


end