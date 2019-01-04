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

  def create
    @address = UsersAddress.new(address_params)
    if @address.save 
      flash[:success] = "* Address has successfully been added"
      redirect_to cookies[:previous_route]
    else
      render 'new_address'
    end
  end

  def update
    @address = UsersAddress.find_by user_id: current_user.id

    if @address.update_attributes(address_params)
      redirect_to cookies[:previous_route]
      flash[:success] = "* Address has successfully been updated"
    else
      render 'edit_address'
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

  def sold 
    @products = Product.where(user_id: current_user.id).where(sold: true)
    @users_addresses = UsersAddress.all
  end

  private

    def address_params 
      params.require(:users_address).permit(:name, :address, :city, :state, :zip, :phone, :user_id)
    end
end
