class StaticPagesController < ApplicationController
  def home
    @user = current_user
    available_items = Product.where(sold: false)
    @newest_items = available_items.order(created_at: :desc)
    @most_expensive_items = available_items.order(price: :desc)
    @add_product = ProductsUser.new
  end
end
