#Controller for all of the product work
require 'pry'


class ProductsController < ApplicationController

  #???? - List a new product (List Item Page)
  def new 
    @user = current_user
    @product = Product.new(user: @user) #@product = current_user.products.build

  end

  # show a single product
  def show
    
  end

  # Show a collection/many of products (Shopping Page)
  def index
    @user = current_user  
    @products = Product.where(sold: false)

    if params[:product_search]
      @products = Product.search(params[:product_search])
    end

    #binding.pry

    @add_product = ProductsUser.new
  end


  #List a new product (List Item Page)
  def create
    binding.pry

    @product = current_user.products.build(product_params)
    if @product.save 
      redirect_to root_url
    else
      nil
      #handle when save doesn't work 
    end

  end

  def edit 
    @product = Product.find(params[:product_id])

  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      flash[:success] = "Profile updated"
      redirect_to selling_product_path
    else
      #Make updates here later
      redirect_to edit_listed_product_path
    end
  end

  #Items that a user has for sale 
  def selling
    @user = current_user
    @products = Product.all
  end

  #Removing a product that a user listed 
  def destroy
    Product.find(params[:product_id]).destroy

    #Product.find_by(id: params[:id]).destroy

    flash[:success] = "Product Deleted"

    redirect_to selling_product_path
  end

 

  def purchase

    @user = current_user
    @products = Product.all

    @cart = ProductsUser.where(user_id: @user.id)

    #binding.pry 

    @order = Order.new(user_id: @user.id)
    @order.save

    @cart.each do |cart_product|
      #binding.pry
      item = ItemsOrder.new(order_id: @order.id, product_id: cart_product.product_id)
      item.save
      @products.each do |product|
        if product.id == cart_product.product_id
          Product.find_by(id: product.id).update_attributes!(sold: 1)
          #product = Product.find_by(id: @products.id).update_attributes!(sold: 1)
          #ProductsUser.find_by(product_id: params[:product_id]).destroy
        end

        #binding.pry 

        ProductsUser.where(user_id: @user.id).destroy_all
        Product
      end 
    end

    redirect_to root_path
  end

  def sold
    @products = Product.where(user_id: current_user.id).where(sold: true)
    #binding.pry

  end


  private

    def product_params #Page 361 - We want to require the params hash to have a :product attribute, and we want to permit the title, price, and picture_url. This code returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing).
      params.require(:product).permit(:title, :price, :picture_url)
    end


end









