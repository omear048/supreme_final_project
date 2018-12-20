require 'spec_helper'

#require 'capybara/rails' 

describe "StaticPages" do
  subject { page }  #eliminates the repitition on the page variable 
  
  describe "home page" do 
    before { visit root_path }

    describe "home page content" do
      it { should have_content('Welcome to Supreme') }
      it { should have_content('December 6th Drop Sneak Peak') }

      it "should have the following images" do
        expect(page.find('#image1')['src']).to have_content "https://assets.supremenewyork.com/152582/zo/cc2kidN5yOc1.jpg"
        expect(page.find('#image2')['src']).to have_content "https://assets.supremenewyork.com/152609/zo/qRgO0c9RD-A.jpg"
        expect(page.find('#image3')['src']).to have_content "https://assets.supremenewyork.com/152194/zo/IkvqF0CQAV10.jpg"
        expect(page.find('#image4')['src']).to have_content "https://assets.supremenewyork.com/155724/ma/F2AIk7DKuhc.jpg"
      end

      it "should route to shop page (products_path) when image_1 is clicked" do
        click_link('image_1')
        expect(current_path).to eq(products_path)
      end

      it "should route to shop page (products_path) when image_2 is clicked" do 
        click_link('image_2')
        expect(current_path).to eq(products_path)
      end

      it "should route to shop page (products_path) when image_3 is clicked" do 
        click_link('image_3')
        expect(current_path).to eq(products_path)
      end

      it "should route to shop page (products_path) when image_4 is clicked" do 
        click_link('image_4')
        expect(current_path).to eq(products_path)
      end

    end

    describe "top menu static fields" do
      it { should have_link("supreme new york", href: root_path) }
      it { should have_link('Home', href: root_path) }
      it { should have_link('Shop', href: products_path) }
      it { should have_link('About', href: "https://www.supremenewyork.com/about" ) }
    end 

    describe "top menu when user not signed in" do
      it { should have_link('Member Login', href: new_user_session_path) }
      it { should have_link('Member Signup', href: new_user_registration_path) }
    end

    describe "top menu when user signed in" do
      let(:user) { FactoryGirl.create(:user) }
      before do 
        visit new_user_session_path
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
        click_button('Log in')
      end
      it { should have_content('Account') }
      it { should have_link('Sell', href: new_product_path) }
      it { should have_link('Selling', href: selling_product_path) }
      it { should have_link('Cart', href: users_cart_path) }
      it { should have_link('Your Account', href: account_details_path) }
      it { should have_link('Sign Out', href: destroy_user_session_path) }
    end
  end
end
