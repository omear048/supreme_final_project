require 'pry'

class ProductsController < ApplicationController

  def new 
    @user = current_user
    @product = Product.new(user: @user) #@product = current_user.products.build

  end

  # show a single product
  def show
    
  end

  # show a collection/many of products
  def index
    @user = current_user  
    #@product = Product.new(user: @user)
    #@product = current_user.products.build(user: )
    @products = Product.all

    @add_product = ProductsUser.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save 
      redirect_to root_url
    else
      nil
      #handle when save doesn't work 
    end

  end

  def cart
  end

  def destroy
  end

  private

    def product_params #Page 361 - We want to require the params hash to have a :product attribute, and we want to permit the title, price, and picture_url. This code returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing).
      params.require(:product).permit(:title, :price, :picture_url)
    end


end









