require "spec_helper"

describe "Products users pages" do
  subject { page }  #eliminates the repitition on the page variable 

  before do 
    @user1 = FactoryGirl.create(:user) 
    @user1_product1 = FactoryGirl.create(:product, user: @user1, title: "Supreme Box Logo Hoodie", price: 750, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user1_product2 = FactoryGirl.create(:product, user: @user1, title: "Supreme Box Logo Crewneck", price: 500, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user1_product3 = FactoryGirl.create(:product, user: @user1, title: "Supreme Box Logo T-Shirt", price: 450, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user1_product4_sold = FactoryGirl.create(:product, sold: true, user: @user1, title: "Supreme Box Logo T-Shirt", price: 450, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    
    @user2 = FactoryGirl.create(:user) 
    @user2_product1 = FactoryGirl.create(:product, user_id: @user2.id, title: "Supreme Box Logo", price: 750, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user2_product2 = FactoryGirl.create(:product, user_id: @user2.id, title: "Supreme Box Logo Louis Vuitton", price: 5000, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009')
    @user2_product3 = FactoryGirl.create(:product, user_id: @user2.id, title: "Supreme Box Logo T-Shirt", price: 450, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user2_product4_sold = FactoryGirl.create(:product, sold: true, user: @user2, title: "Supreme Box Logo T-Shirt", price: 450, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 

    sign_in @user1

    visit products_path 
    click_button "add_#{@user1_product1.id}_to_cart" 
    click_button "add_#{@user2_product1.id}_to_cart"
    click_button "add_#{@user2_product2.id}_to_cart"
    click_button "add_#{@user2_product3.id}_to_cart"
    visit users_cart_path
  end

  describe "shopping cart page" do 
    describe "static content" do 
      it { should have_content("Shopping Cart") }
      it { should have_content("Item") }
      it { should have_content("Price") }
      it { should have_content("Removal") }
      it { should have_content("Total") }
    end

    describe "products in cart that should be listed within the table" do 
      it { should have_content("#{@user1_product1.title}") }
      it { should have_content("#{@user2_product1.title}") }
      it { should have_content("#{@user2_product2.title}") }
      it { should have_content("#{@user2_product3.title}") }

      it { should have_content("#{ActionController::Base.helpers.number_to_currency(@user1_product1.price)}") }
      it { should have_content("#{ActionController::Base.helpers.number_to_currency(@user2_product1.price)}") } 
      it { should have_content("#{ActionController::Base.helpers.number_to_currency(@user2_product2.price)}") }
      it { should have_content("#{ActionController::Base.helpers.number_to_currency(@user2_product3.price)}") }
    end

    describe "cart total" do 
      cart_total = 0
      it "should add the price of all products in the cart together and display at bottom of table" do 
        sql = "SELECT ps.*, p.price FROM products_users ps INNER JOIN products p ON ps.product_id = p.id"
        products_with_prices = ActiveRecord::Base.connection.execute(sql)
        products_with_prices.each do |item|
          cart_total += item["price"] if item["user_id"] == @user1.id
        end
        should have_content("#{ActionController::Base.helpers.number_to_currency(cart_total)}")
      end
    end

    describe "clicking 'Remove From Cart' button" do 
      it "should remove product from cart (destruction of record from products_users table)" do 
        click_link 'Remove from Cart', href: delete_products_users_path(@user1_product1.id) 
        should have_no_content("#{@user1_product1.title}")
      end

      it "should reload shop page and display a success message" do 
        click_link 'Remove from Cart', href: delete_products_users_path(@user1_product1.id) 
        expect(current_path).to eq(users_cart_path)
        expect(page).to have_content("Product removed from cart")
      end
    end

    describe "checkout link" do 
      it { should have_link "Checkout", href: user_checkout_path }
    end
  end

  describe "checkout page" do 
    before do 
      click_link "Checkout" 
    end

    describe "landing page after clicking checkout" do 
      it { expect(current_path).to eq(user_checkout_path) }
    end

    describe "static content on page" do 
      it { should have_content("Checkout") }
    end

    describe "when user has not yet added a shipping address" do 
      it { should have_content("Please add your shipping information to checkout") }
      it { should have_link "Update Shipping Information", href: new_address_path }
    end

    describe "when user has added a shipping address" do
      before do 
        visit new_address_path
        fill_in "Name", with: "Kris OMeara"
        fill_in "Address", with: "2101 Market Street Apt. 512"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zip", with: 80205
        fill_in "Phone", with: 612-247-3127
        click_button "Add Address"
      end

      describe "shipping address" do 
        let(:users_address) { UsersAddress.find_by(user_id: @user1.id) }
      
        it "should display the users full shipping address" do 
          should have_content(users_address.name)
          should have_content(users_address.address)
          should have_content(users_address.city)
          should have_content(users_address.state)
          should have_content(users_address.zip)
        end

        it "should have link to update shipping address" do 
          should have_link "Update Shipping Address", href: new_address_path 
        end
      end

      describe "checkout total" do
        it "should display the checkout total" do 
          sql = "SELECT ps.*, p.price FROM products_users ps INNER JOIN products p ON ps.product_id = p.id"
          products_with_prices = ActiveRecord::Base.connection.execute(sql)
          cart_total =0
          products_with_prices.each do |item|
            cart_total += item["price"] if item["user_id"] == @user1.id
          end

          should have_content("#{ActionController::Base.helpers.number_to_currency(cart_total)}")
        end
      end

      describe "purchase button" do 
        let(:users_cart) { ProductsUser.where(user_id: @user1.id) }

        before do 
          click_button "Purchase"
        end

        describe "thanks for your purchase page" do
          it { expect(current_path).to eq(user_checkout_success_path) }
          it { should have_content ("Thanks for your purchase!") }
        end

        describe "shopping cart page" do 
          it "should remove purchased products from cart" do 
            visit users_cart_path
            should have_no_content("#{@user1_product1.title}") 
            should have_no_content("#{@user2_product1.title}") 
            should have_no_content("#{@user2_product2.title}") 
            should have_no_content("#{@user2_product3.title}") 
            should have_content(0)
          end
        end

        describe "shop page" do 
          it "should remove the purchased products from the shop page" do 
            visit products_path
            should have_no_button("add_#{@user1_product1.id}_to_cart") 
            should have_no_content("add_#{@user2_product1.id}_to_cart") 
            should have_no_content("add_#{@user2_product2.id}_to_cart") 
            should have_no_content("add_#{@user2_product3.id}_to_cart") 
          end
        end
      end
    end
  end 
end