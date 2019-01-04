require 'spec_helper'

describe "Products pages" do
  subject { page } 

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

    @user3 = FactoryGirl.create(:user) 
    @user3_product1 = FactoryGirl.create(:product, user_id: @user3.id, title: "Supreme Box Logo Hat", price: 200, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user3_product2 = FactoryGirl.create(:product, user_id: @user3.id, title: "Supreme Box Logo Crewneck", price: 375, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user3_product3 = FactoryGirl.create(:product, user_id: @user3.id, title: "Supreme Box Logo T-Shirt", price: 375, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user3_product4_sold = FactoryGirl.create(:product, sold: true, user: @user3, title: "Supreme Box Logo T-Shirt", price: 450, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 

    @user4 = FactoryGirl.create(:user)   
    @user4_product1 = FactoryGirl.create(:product, user_id: @user4.id, title: "Supreme Box Logo Hat", price: 200, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user4_product2 = FactoryGirl.create(:product, user_id: @user4.id, title: "Supreme Box Logo Crewneck", price: 375, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    @user4_product3 = FactoryGirl.create(:product, user_id: @user4.id, title: "Louis Vuitton T-Shirt", price: 375, picture_url: 'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hooded-Sweatshirt-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538082009') 
    sign_in @user4

    @user5 = FactoryGirl.create(:user)
  end

  describe "new product page" do 
    before { visit new_product_path }

    describe "static content on page" do
      it { should have_content('List Item For Sale') }
      it { should have_content('Title') }
      it { should have_content('Price') }
      it { should have_content('Picture url') }
      it { should have_button('List Product') }
    end

    describe "product creation" do 
      let(:submit) { "List Product" }

      describe "with invalid information" do
        it "should not create a product" do 
          expect { click_button submit }.not_to change(Product, :count)
        end

        it "should display an error" do
          fill_in 'Title', with: " "
          fill_in 'Price', with: "ABC"
          fill_in 'Picture url', with: " "
          click_button "List Product"
          expect(page).to have_content("* Title can't be blank") 
          expect(page).to have_content("* Price is not a number")
          expect(page).to have_content("* Picture url can't be blank")
          expect(page).to have_content("The form contains 3 errors.")
        end
      end

      describe "with valid information" do
        before do 
          fill_in 'Title', with: "Supreme Box Logo Hoodie"
          fill_in 'Price', with: 1750
          fill_in 'Picture url', with: "https://stockx.imgix.net/products/streetwear/Supreme-Compact-Logo-Hoodie-Black.jpg?fit=fill&bg=FFFFFF&w=358&h=255&auto=format,compress&trim=color&q=90&dpr=2&updated_at=1539713149"
        end

        it "should create a new product with correct data" do
          expect { click_button submit }.to change(Product, :count).by(1)
          last_product = Product.first
          expect(last_product.title).to eq 'Supreme Box Logo Hoodie' 
          expect(last_product.price).to eq 1750
          expect(last_product.picture_url).to eq "https://stockx.imgix.net/products/streetwear/Supreme-Compact-Logo-Hoodie-Black.jpg?fit=fill&bg=FFFFFF&w=358&h=255&auto=format,compress&trim=color&q=90&dpr=2&updated_at=1539713149"
          expect(last_product.user_id).to eq 4
          expect(last_product.sold).to eq false
        end

        it "should reroute to the for sale page and display success message" do 
          click_button submit
          expect(current_path).to eq(products_path)
          expect(page).to have_content("*Your product has been listed")
        end
      end
    end
  end

  describe "selling page" do 
    before { visit selling_product_path }

    describe "static content on page" do 
      it { should have_content('Items You Are Selling') }
      it { should have_content('Item') }
      it { should have_content('Price') }
      it { should have_content('Edit') }
      it { should have_content('Delete') }
    end

    describe "when a user has products listed for sale" do      
      describe "table data" do 
        let(:listed_products) { Product.where(user_id: @user4.id) }
        let(:other_users_listed_products) { Product.where.not(user_id: @user4.id) }

        it 'should list all products the user has for sale' do
          listed_products.each do |item|
            expect(page).to have_content(item.title)
            should have_content("#{ActionController::Base.helpers.number_to_currency(item.price)}")
            should have_link('Edit Item', href: edit_listed_product_path(item.id))
            should have_link('Unlist Item', href: delete_listed_product_path(item.id))
          end  
        end

        it 'should not list products other users have for sale' do 
          other_users_listed_products.each do |item|
            should have_no_link('Edit Item', href: edit_listed_product_path(item.id))
          end 
        end
      end

      describe "product destruction" do
        let(:listed_products) { Product.where(user_id: @user4.id) }

        it "should delete the product from table" do 
          item = listed_products.first
          expect do 
            click_link 'Unlist Item', href: delete_listed_product_path(item.id)
          end.to change(Product, :count).by(-1)
        end

        describe "activity after product deleted" do 
          before do
            click_link 'Unlist Item', href: delete_listed_product_path(listed_products.first.id) 
          end

          it "should reload the updated selling page" do
            expect(current_path).to eq(selling_product_path)
          end

          it "should trigger a flash message confirming product destruction" do 
            should have_content("*Your product listing has been removed") 
          end
        end
      end
    end

    describe "when a user has no products listed for sale" do
      before do 
        sign_out
        sign_in @user5
      end

      describe "table data" do 
        let(:listed_products) { Product.where(user_id: @user5.id) }
        let(:other_users_listed_products) { Product.where.not(user_id: @user5.id) }

        it { should have_no_content "Edit Item" }
        it { should have_no_content "Unlist Item" }

        it 'should not list products other users have for sale' do 
          other_users_listed_products.each do |item|
            should have_no_link('Edit Item', href: edit_listed_product_path(item.id))
          end 
        end
      end
    end
  end

  describe "edit product page" do 
    before do 
      visit edit_listed_product_path(@user4_product1.id)
    end

    describe "static content on page" do
      it { should have_content("Edit Item") }
      it { should have_content("Title") }
      it { should have_content("Price") }
      it { should have_content("Picture url") }
    end

    describe "default prepopulated form data" do 
      it { should have_content("#{@user4_product1.title}") }
      it { should have_content("#{@user4_product1.price}") }
      it { should have_content("#{@user4_product1.picture_url}") }
    end

    describe "product update with unchanged data" do 
      it "should not create a new product" do
        expect { click_button 'Update Product' }.not_to change(Product, :count)
      end

      it "should not change the data" do
        expect { click_button 'Update Product' }.not_to change { @user4_product1.reload }
      end
    end

    describe "product update with valid changed data" do 
      let(:new_title) { "Louis Vuitton" }
      let(:new_price) { 99999 }
      let(:new_picture_url) { "https://us.louisvuitton.com/eng-us/men/bags/backpacks/_/N-fvehkf" }
      let(:count_before) { Product.count }

      before do 
        fill_in "Title", with: new_title
        fill_in "Price", with: new_price
        fill_in "Picture url", with: new_picture_url
        click_button "Update Product"
      end 

      specify { expect(Product.count).to eq count_before }
      specify { expect(@user4_product1.reload.title).to eq new_title }
      specify { expect(@user4_product1.reload.price).to eq new_price }
      specify { expect(@user4_product1.reload.picture_url).to eq new_picture_url }
      specify { expect(current_path).to eq(selling_product_path) }
      it { should have_content("*Your product listing has been updated") }
    end
    
    describe "product update with invalid data" do 
      before do 
        fill_in "Title", with: ''
        fill_in "Price", with: ''
        fill_in "Picture url", with: ''
        click_button "Update Product"
      end 

      it { should have_content("* Title can't be blank") } 
      it { should have_content("* Price can't be blank") } 
      it { should have_content("* Price is not a number") } 
      it { should have_content("* Picture url can't be blank") } 
      it { should have_content("The form contains 4 errors.") }
    end
  end

  describe "shop page" do 
    before { visit products_path }

    describe "static content on page" do
      it { should have_content("Products For Sale") }
      it { should have_content("Search") }
      it { should have_button("Add To Cart") }
    end

    describe "products" do
      let(:products_available_for_sale) { Product.where(sold: false) }
      let(:products_already_sold) { Product.where(sold: true) }

      it "should have these products listed for sale" do 
        products_available_for_sale.each do |item|
          should have_content("#{item.title}")
          should have_content("#{ActionController::Base.helpers.number_to_currency(item.price)}")
          have_link("Add To Cart", :href => products_users_path(item.id))
        end
      end

      it "should not have these products listed for sale" do 
        products_already_sold.each do |item|
          expect(page).to_not have_button("add_#{@user1_product4_sold.id}_to_cart") #'add_4_to_cart' is a sold item
        end
      end
    end

    describe "add to cart link" do 
      let(:products_available_for_sale) { Product.where(sold: false)  }

      describe "if user is not logged in and adds product to cart" do 
        before do 
          sign_out
          visit products_path
          click_button "add_#{@user1_product3.id}_to_cart" 
        end

        it "should reroute you to the login page" do 
          expect(current_path).to eq(new_user_session_path)
        end
      end

      describe "adding items to cart for first time" do 
        it "should add a new product to the cart (user1_product3)" do 
          expect { click_button "add_#{@user1_product3.id}_to_cart" }.to change(ProductsUser, :count).by(1)
        end

        it "should reload shop page and display a success message" do 
          click_button "add_#{@user1_product3.id}_to_cart" 
          expect(current_path).to eq(products_path)
          expect(page).to have_content("Product added to cart")
        end
      end

      describe "adding duplicate item to cart" do 
        before do 
          click_button "add_#{@user1_product2.id}_to_cart" 
          visit products_path
        end

        it "add duplicate item to cart (user1_product2 twice)" do 
          expect { click_button "add_#{@user1_product2.id}_to_cart" }.not_to change(ProductsUser, :count)
        end

        it "displays a flash message error" do
          click_button "add_#{@user1_product2.id}_to_cart"
          expect(current_path).to eq(products_path)
          expect(page).to have_content("Product already in cart")
        end
      end
    end

    describe "search product feature" do 
      it "should find products containing 'Louis Vuitton' in title; expecting 2 results" do
        fill_in 'Search Items', with: "Louis Vuitton"
        click_button "Search"
        expect(page).to have_css("#product-id-#{@user2_product2.id}")
        expect(page).to have_css("#product-id-#{@user4_product3.id}")
      end
    end
  end
end
