class ChargesController < ApplicationController

  def new
    @user = current_user
    @items = ProductsUser.all
    @products = Product.all  
    @address = UsersAddress.find_by user_id: current_user.id 
  end

  def create
    @user = current_user
    @items = ProductsUser.all
    @products = Product.all

    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end




end