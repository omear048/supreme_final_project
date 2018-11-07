class CartsController < ApplicationController
  def show
    @cart = current_cart  #Method from the application_controller 
  end

  def add_to_cart

  end

  def new
    @user = current_user
  

    @add_product = Products_cart.new(user_id: @user) 
  end

  def create
    puts params
    # @add_product = 

  end
 
end



#Formula for creating the Cart Feature
#User clicks add to Cart
#Product on page added to the Cart Table
#User Navigates to the Cart page
#All of the products that they added to their cart is listed there
#User clicks confirm order and all of the products in that cart are deleted from both tables 