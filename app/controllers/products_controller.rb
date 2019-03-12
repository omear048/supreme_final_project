
class ProductsController < ApplicationController
  def new 
    @product = Product.new(user: current_user) 
  end


  def create 
    @product = Product.new(product_params)
    if @product.save 
      redirect_to products_path
      flash[:success] = "*Your product has been listed"
    else
      render 'new'  # Instance variable must be used since we're using render vs. rerunning the controller action when redirect is used
    end
  end


  def index
    @user = current_user  

    available_items = Product.where(sold: false)
    if params[:product_search]
      @products = (available_items.where("title like ?", "%#{params[:product_search]}%")).order(created_at: :desc)
    else
      @products = (available_items).order(created_at: :desc)
    end

    @products = (@products.where(category: params[:category_search])).order(created_at: :desc) if params[:category_search].present?
    @products = (@products.where(size: params[:size_search])).order(created_at: :desc) if params[:size_search].present?
    @products = (@products.where('price >= ?', params[:price_minimum_search])).order(created_at: :desc) if params[:price_minimum_search].present?
    @products = (@products.where('price <= ?', params[:price_maximum_search])).order(created_at: :desc) if params[:price_maximum_search].present?    


    if @products == []
      flash[:fail] = "*Sorry no results match your search filter"
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
    @users_address = UsersAddress.find_by(user_id: @user.id)
    @products = Product.all
    @cart = ProductsUser.where(user_id: @user.id)
    @order = Order.new(user_id: @user.id, name: @users_address.name, street: @users_address.address, city: @users_address.city,
                       state: @users_address.state, zip: @users_address.zip, phone: @users_address.phone)
    @order.save

    @cart.each do |cart_product|
      item = ItemsOrder.new(order_id: @order.id, product_id: cart_product.product_id)
      item.save
      @products.each do |product|
        if product.id == cart_product.product_id
          Product.find_by(id: product.id).update_attributes!(sold: 1, users_address_id: @users_address.id)
        end
        ProductsUser.where(user_id: @user.id).destroy_all
      end 
    end
    redirect_to user_checkout_success_path
  end

  def show
    @user = current_user
    @product = Product.find(params[:product_id])
    @add_product = ProductsUser.new
  end

  private

    def product_params 
      params.require(:product).permit(:user_id, :title, :price, :size, :category, :subcategory, 
                                      :designer, :description, :product_image_1, :product_image_2, :product_image_3)
    end

    def filtering_params(params)
      params.slice(:product_size, :product_category)
    end
end
