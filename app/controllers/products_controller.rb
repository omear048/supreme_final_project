require 'pry'

class ProductsController < ApplicationController
  def new 
    @product = Product.new(user: current_user) 
  end

  def create #tested
    @product = Product.new(product_params)
    if @product.save 
      redirect_to products_path
      flash[:success] = "*Your product has been listed"
    else
      render 'new'
    end
  end

  def index
    @user = current_user  
    @products = Product.where(sold: false)
    if params[:product_search]
      @products = Product.search(params[:product_search])
    end
    @add_product = ProductsUser.new
  end

  def edit 
    @product = Product.find(params[:product_id])
  end

  def update 
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "*Your product listing has been updated"
      redirect_to selling_product_path
    else
      #redirect_to edit_listed_product_path(@product.id)
      render 'edit'
    end
  end

  def selling 
    @user = current_user
    @products = Product.all
  end

  def destroy 
    Product.find(params[:product_id]).destroy
    flash[:success] = "*Your product listing has been removed"
    redirect_to selling_product_path
  end

  def purchase 
    @user = current_user
    @products = Product.all
    @cart = ProductsUser.where(user_id: @user.id)
    @order = Order.new(user_id: @user.id)
    @order.save

    @cart.each do |cart_product|
      item = ItemsOrder.new(order_id: @order.id, product_id: cart_product.product_id)
      item.save
      @products.each do |product|
        if product.id == cart_product.product_id
          Product.find_by(id: product.id).update_attributes!(sold: 1)
        end
        ProductsUser.where(user_id: @user.id).destroy_all
      end 
    end
    redirect_to user_checkout_success_path
  end

  private

    def product_params #Page 361 - We want to require the params hash to have a :product attribute, and we want to permit the title, price, and picture_url. This code returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing).
      params.require(:product).permit(:user_id, :title, :price, :picture_url)
    end
end









