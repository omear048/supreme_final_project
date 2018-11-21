class AccountDetailsController < ApplicationController
  include AccountDetailsHelper

  def homepage
  end

  def new_address
    redirect_to edit_address_path if UsersAddress.exists?(user_id: current_user.id) 
    @user = current_user
    @address = UsersAddress.new
  end

  def edit_address
    @user = current_user
    @address = UsersAddress.find_by user_id: current_user.id 
  end


    #List a new product (List Item Page)
  def create
    #@address = current_user.usersaddress.build(address_params)
   #binding.pry 
   @address = UsersAddress.new(address_params)
       # binding.pry
    if @address.save 
      redirect_to root_path #edit_address_path
    else
      nil
      #handle when save doesn't work 
    end
  end

  def update
    @address = UsersAddress.find_by user_id: current_user.id

    if @address.update_attributes(address_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      #Make updates here later
      redirect_to edit_listed_product_path
    end
  end


  def orders

    @orders = current_user.orders
    @items = []

    @orders.each do |order|
      order.items_orders.each do |item|
        @items << item
      end
    end

  end



  private



    def address_params #Page 361 - We want to require the params hash to have a :product attribute, and we want to permit the title, price, and picture_url. This code returns a version of the params hash with only the permitted attributes (while raising an error if the :user attribute is missing).
      params.require(:users_address).permit(:name, :address, :city, :state, :zip, :phone, :user_id)
    end


end
