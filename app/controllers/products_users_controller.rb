class ProductsUsersController < ApplicationController
  def create 
    @add_product = ProductsUser.new(products_user_params)
    if @add_product.save
      flash[:success] = "Product added to cart"
      redirect_to products_path
    elsif 
      flash[:fail] = "Product already in cart"
      redirect_to products_path
    end
  end

  def cart 
    @user = current_user
    @items = ProductsUser.all
    @products = Product.all
  end

  def checkout 
    @user = current_user
    @items = ProductsUser.all
    @products = Product.all  
    @address = UsersAddress.find_by user_id: current_user.id 
  end

  def destroy 
    ProductsUser.find_by(product_id: params[:product_id]).destroy
    flash[:success] = "Product removed from cart"
    redirect_to users_cart_path
  end

  def success 
  end

  private

    def products_user_params
      params.require(:products_user).permit(:user_id, :product_id)
    end
end