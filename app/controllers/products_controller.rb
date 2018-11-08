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
    #@product = Product.new(user: @user)
    #@product = current_user.products.build(user: )
    @products = Product.all

    @add_product = ProductsUser.new
  end

  #List a new product (List Item Page)
  def create
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

  def cart
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

    flash[:success] = "User Deleted"

    redirect_to selling_product_path
  end

  private

    def product_params #Page 361 - We want to require the params hash to have a :product attribute, and we want to permit the title, price, and picture_url. This code returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing).
      params.require(:product).permit(:title, :price, :picture_url)
    end


end









