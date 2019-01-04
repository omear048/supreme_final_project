require 'spec_helper'

describe "Products users pages" do
  subject { page } 

  before do 
    @user1 = FactoryGirl.create(:user) 
    @user1_product1 = FactoryGirl.create(:product, user: @user1, title: "Supreme Box Logo Hoodie", price: 750, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user1_product2 = FactoryGirl.create(:product, user: @user1, title: "Supreme Box Logo Crewneck", price: 500, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user1_product3 = FactoryGirl.create(:product, user: @user1, title: "Supreme Box Logo T-Shirt (Rare)", price: 850, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    
    @user2 = FactoryGirl.create(:user) 
    @user2_product1 = FactoryGirl.create(:product, user_id: @user2.id, title: "Supreme Box Logo User 2", price: 950, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user2_product2 = FactoryGirl.create(:product, user_id: @user2.id, title: "Supreme Box Logo Louis Vuitton", price: 5000, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009')
    @user2_product3 = FactoryGirl.create(:product, user_id: @user2.id, title: "Supreme Box Logo T-Shirt User 2", price: 450, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user2_product4_sold = FactoryGirl.create(:product, sold: true, user: @user2, title: "Supreme Box Logo T-Shirt Uaer 2", price: 650, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 

    sign_in @user1

    visit products_path 
    click_button "add_#{@user1_product1.id}_to_cart" 
    click_button "add_#{@user2_product1.id}_to_cart"
    click_button "add_#{@user2_product2.id}_to_cart"
    click_button "add_#{@user2_product3.id}_to_cart"
    visit account_details_path
  end

  describe "account management homepage" do 
    describe "static content and links" do 
      it { should have_content("Account Management") }
      it { should have_link("Manage Address", href: new_address_path) }
      it { should have_link("Purchase History", href: account_details_orders_path(@user1.id)) }
      it { should have_link("Items Sold", href: sold_path) }
    end
  end

  describe "address pages" do
    describe "when user adds shipping address information for the first time" do 
      before { click_link "Manage Address" }

      describe "new_address path" do 
        it { expect(current_path).to eq(new_address_path) }
      end

      describe "static content on page" do
        it { should have_content("Add Shipping Address Information") }
        it { should have_content("Name") }
        it { should have_content("Address") }
        it { should have_content("City") }
        it { should have_content("State") }
        it { should have_content("Zip") }
        it { should have_content("Phone") }
      end 

      describe "error messages if data is not added correctly" do 
        before do 
          fill_in "Name", with: ''
          fill_in "Address", with: ''
          fill_in "City", with: ''
          fill_in "State", with: ''
          fill_in "Zip", with: ''
          fill_in "Phone", with: ''
          click_button "Add Address"
        end 

        it { should have_content("The form contains 6 errors.") }
        it { should have_content("* Name can't be blank") } 
        it { should have_content("* Address can't be blank") } 
        it { should have_content("* City can't be blank") } 
        it { should have_content("* State can't be blank") } 
        it { should have_content("* Zip can't be blank") } 
        it { should have_content("* Zip is not a number") } 
        it { should have_no_content("* Phone can't be blank") }
      end

      describe "when valid data populated and 'Add Address' clicked" do 
        before do 
          fill_in "Name", with: 'Kris OMeara'
          fill_in "Address", with: '2101 Market Street Apt. 512'
          fill_in "City", with: 'Denver'
          fill_in "State", with: 'CO'
          fill_in "Zip", with: 80205
          fill_in "Phone", with: '612-247-3127'
          @previous_address_count = UsersAddress.all.count
          click_button "Add Address"
        end

        it { expect(UsersAddress.all.count).to eq(@previous_address_count + 1) }
        it { expect(current_path).to eq(account_details_path) }
        it { should have_content("* Address has successfully been added") }
      end
    end

    describe "when user changes/updates shipping address information" do
      before do 
        click_link "Manage Address"
        fill_in "Name", with: 'Kris OMeara'
        fill_in "Address", with: '2101 Market Street Apt. 512'
        fill_in "City", with: 'Denver'
        fill_in "State", with: 'CO'
        fill_in "Zip", with: 80205
        fill_in "Phone", with: '612-247-3127'
        click_button "Add Address"
        click_link "Manage Address" 
      end

      describe "new_address path" do 
        it { expect(current_path).to eq(edit_address_path) }
      end

      describe "static content on page" do
        it { should have_content("Update Shipping Address Information") }
        it { should have_content("Name") }
        it { should have_content("Address") }
        it { should have_content("City") }
        it { should have_content("State") }
        it { should have_content("Zip") }
        it { should have_content("Phone") }
      end 

      describe "error messages if data is not added correctly" do 
        before do 
          fill_in "Name", with: ''
          fill_in "Address", with: ''
          fill_in "City", with: ''
          fill_in "State", with: ''
          fill_in "Zip", with: ''
          fill_in "Phone", with: ''
          click_button "Update Address"
        end 

        it { should have_content("The form contains 6 errors.") }
        it { should have_content("* Name can't be blank") } 
        it { should have_content("* Address can't be blank") } 
        it { should have_content("* City can't be blank") } 
        it { should have_content("* State can't be blank") } 
        it { should have_content("* Zip can't be blank") } 
        it { should have_content("* Zip is not a number") } 
        it { should have_no_content("* Phone can't be blank") }
      end

       describe "when valid data populated and 'Add Address' clicked" do 
        before do 
          fill_in "Name", with: 'Tyler VanNurden'
          fill_in "Address", with: '2101 Market Street Apt. 512'
          fill_in "City", with: 'Denver'
          fill_in "State", with: 'CO'
          fill_in "Zip", with: 80205
          fill_in "Phone", with: '612-247-3127'
          @previous_address_count = UsersAddress.all.count
          click_button "Update Address"
        end

        it { expect(UsersAddress.all.count).to eq(@previous_address_count) }
        it { expect(current_path).to eq(account_details_path) }
        it { should have_content("* Address has successfully been updated") }
      end
    end
  end

  describe "order history" do 
    describe "purchase history link" do 
      before { click_link "Purchase History" }
      it { expect(current_path).to eq(account_details_orders_path(@user1.id)) }
    end

    describe "when user does not have a purchase history" do 
      before { visit account_details_orders_path(@user1.id) }

      describe "message on screen when no purchases exist" do 
        it { should have_content("Order History") }
        it { should have_content("You have not yet made any purchases") }
      end
    end

    describe "when user does have a purchase history" do 
      before do 
        # add shipping address data for @user1
        click_link "Manage Address"
        fill_in "Name", with: 'Tyler VanNurden'
        fill_in "Address", with: '2101 Market Street Apt. 512'
        fill_in "City", with: 'Denver'
        fill_in "State", with: 'CO'
        fill_in "Zip", with: 80205
        fill_in "Phone", with: '612-247-3127'
        click_button "Add Address"

        # @user1 purchase #1: @user1_product1, @user2_product1, @user2_product2, @user2_product3 already in cart
        visit user_checkout_path
        click_button "Purchase"

        # @user1 purchase #2 (user1_product2)
        visit products_path
        click_button "add_#{@user1_product2.id}_to_cart" 
        visit user_checkout_path
        click_button "Purchase"

        # logout @user1 & login @user2
        sign_out
        sign_in @user2

        # add shipping address data for @user2
        visit new_address_path
        fill_in "Name", with: 'Nolan VanNurden'
        fill_in "Address", with: '2201 Market Street Apt. 517'
        fill_in "City", with: 'Denver'
        fill_in "State", with: 'CO'
        fill_in "Zip", with: 80209
        fill_in "Phone", with: '612-883-4257'
        click_button "Add Address"

        # @user2 purchase #1 (user1_product3)
        visit products_path
        click_button "add_#{@user1_product3.id}_to_cart" 
        visit user_checkout_path
        click_button "Purchase"

        # logout @user2 & login @user1
        sign_out
        sign_in @user1

        # visit Order History page
        visit account_details_path
        click_link "Purchase History" 

        @user1_order_numbers = Order.where(user_id: @user1.id)
        @user2_order_numbers = Order.where(user_id: @user2.id)
      end

      describe "order history data displayed in screen" do 
        describe "static data in tables" do 
          it { should have_content("Product Title") }
          it { should have_content("Price") }
          it { should have_content("Total") }
        end

        describe "unique order specific data" do 
          it "should display the order numbers associated with @user1" do 
            @user1_order_numbers.each do |order|
              should have_content(order.id) 
            end
          end

          it "should not display the order number associated with @user2" do 
            @user2_order_numbers.each do |order|
              should have_no_content(order.id)
            end
          end
          
          it "should display the title and price of each product purchased by @user1" do 
            should have_content(@user1_product1.title) 
            should have_content("#{ActionController::Base.helpers.number_to_currency(@user1_product1.price)}")

            should have_content(@user2_product1.title) 
            should have_content("#{ActionController::Base.helpers.number_to_currency(@user2_product1.price)}")

            should have_content(@user2_product2.title)
            should have_content("#{ActionController::Base.helpers.number_to_currency(@user2_product2.price)}")

            should have_content(@user2_product3.title)
            should have_content("#{ActionController::Base.helpers.number_to_currency(@user2_product3.price)}")

            should have_content(@user1_product2.title)
            should have_content("#{ActionController::Base.helpers.number_to_currency(@user1_product2.price)}")
          end 

          it "should not display the title and price of eash product purchased by @user2" do 
            should have_no_content(@user1_product3.title)
            should have_no_content("#{ActionController::Base.helpers.number_to_currency(@user1_product3.price)}")
          end

          it "should display the total price of each order made by @user1" do 
            total_1 = @user1_product1.price + @user2_product1.price + @user2_product2.price + @user2_product3.price
            should have_content("#{ActionController::Base.helpers.number_to_currency(total_1)}")

            total_2 = @user1_product2.price
            should have_content("#{ActionController::Base.helpers.number_to_currency(total_2)}")
          end

          it "should not display the total price of order made by @user2" do 
            total_3 = @user1_product3.price
            should have_no_content("#{ActionController::Base.helpers.number_to_currency(total_3)}")
          end
        end
      end
    end
  end

  describe "items sold" do 
    describe "items sold link" do 
      before { click_link "Items Sold" }
      it { expect(current_path).to eq(sold_path) }
    end

    describe "when user does not have a selling history" do 
      before { visit sold_path }

      it "should have the following content displayed on the page" do 
        should have_content("Items Sold")
        should have_content("You have not sold any products")
      end
    end

    describe "when user has a selling history" do 
      before do 
        # add shipping address data for @user1
        click_link "Manage Address"
        fill_in "Name", with: 'Tyler VanNurden'
        fill_in "Address", with: '2101 Market Street Apt. 512'
        fill_in "City", with: 'Denver'
        fill_in "State", with: 'CO'
        fill_in "Zip", with: 80205
        fill_in "Phone", with: '612-247-3127'
        click_button "Add Address"

        # @user1 purchase #1: @user1_product1, @user2_product1, @user2_product2, @user2_product3 already in cart
        visit user_checkout_path
        click_button "Purchase"

        # @user1 purchase #2 (user1_product2)
        visit products_path
        click_button "add_#{@user1_product2.id}_to_cart" 
        visit user_checkout_path
        click_button "Purchase"

        # logout @user1 & login @user2
        sign_out
        sign_in @user2

        # add shipping address data for @user2
        visit new_address_path
        fill_in "Name", with: 'Nolan VanNurden'
        fill_in "Address", with: '2201 Market Street Apt. 517'
        fill_in "City", with: 'Denver'
        fill_in "State", with: 'CO'
        fill_in "Zip", with: 80209
        fill_in "Phone", with: '612-883-4257'
        click_button "Add Address"

        # @user2 purchase #1 (user1_product3)
        visit products_path
        click_button "add_#{@user1_product3.id}_to_cart" 
        visit user_checkout_path
        click_button "Purchase"

        # logout @user2 & login @user1
        sign_out
        sign_in @user1

        # visit Order History page
        visit account_details_path
        click_link "Items Sold" 

        @user1_order_numbers = Order.where(user_id: @user1.id)
        @user2_order_numbers = Order.where(user_id: @user2.id)
      end

      describe "selling history data displayed in screen" do 
        describe "static data in tables" do 
          it { should have_content("Product Title") }
          it { should have_content("Price") }
          it { should have_content("Date of Sale") }
        end

        describe "unique products sold data displayed in table" do 
          it "should display the 'title', 'price', and 'data of sale' for each product sold by @user1" do 
            should have_content(@user1_product1.title) 
            should have_content(@user1_product1.price) 
            should have_content(@user1_product1.updated_at)

            should have_content(@user1_product2.title) 
            should have_content(@user1_product2.price) 
            should have_content(@user1_product2.updated_at)

            should have_content(@user1_product3.title)
            should have_content(@user1_product3.price)
            should have_content(@user1_product3.updated_at)
          end 

          it "should not display the 'title', 'price', and 'data of sale' for each product sold by @user2" do 
            should have_no_content(@user2_product1.title) 
            should have_no_content(@user2_product1.price) 

            should have_no_content(@user2_product2.title) 
            should have_no_content(@user2_product2.price) 

            should have_no_content(@user2_product3.title)
            should have_no_content(@user2_product3.price)

            should have_no_content(@user2_product4_sold.title)
            should have_no_content(@user2_product4_sold.price)
          end
        end
      end
    end
  end
end
