require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end
 
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:name) }
  it { should respond_to(:phone) }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
    before { @user.name = nil }
    it { should_not be_valid }
  end 

  describe "when name is too long" do 
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do 
    it "should be invalid" do 
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                        foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end 
    end
  end

  describe "when email format is valid" do
     it "should be valid" do
       addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
       addresses.each do |valid_address|
         @user.email = valid_address
         expect(@user).to be_valid
       end
    end 
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid } 
  end

  describe "when password is not present" do 
    before do 
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end 
  end

  describe "product associations" do 
    before { @user.save }
    let!(:older_product) do 
      FactoryGirl.create(:product, user: @user, created_at: 1.day.ago)
    end

    let!(:newer_product) do 
      FactoryGirl.create(:product, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right products in the right order (newest to oldest)" do 
      expect(@user.products.to_a).to eq [newer_product, older_product]
    end

    it "should destroy the associated products" do 
      products = @user.products.to_a
      @user.destroy
      expect(products).not_to be_empty
      products.each do |product|
        expect(Product.where(id: product.id)).to be_empty
      end
    end
  end

  describe "products_user associations" do 
    before { @user.save }
    let!(:first_product) do 
      FactoryGirl.create(:product, user: @user, created_at: 1.day.ago)
    end

    let!(:second_product) do 
      FactoryGirl.create(:product, user: @user, created_at: 1.hour.ago)
    end

    let!(:first_product_in_cart) do 
      FactoryGirl.create(:products_user, user: @user, product: first_product)
    end

    let!(:second_product_in_cart) do 
      FactoryGirl.create(:products_user, user: @user, product: second_product)
    end

    it "should destroy the associated products_users" do
      products_user_cart = @user.products_users.to_a
      @user.destroy
      expect(products_user_cart).not_to be_empty
      products_user_cart.each do |product|
        expect(ProductsUser.where(id: product.id)).to be_empty
      end  
    end
  end

  describe "users_address associations" do 
    before do 
      @user.save 
      FactoryGirl.create(:users_address, user: @user)
    end

    it "should not allow the user to have more than one address" do
      expect { FactoryGirl.create(:users_address, name: "Kris OMeara 2", user: @user) }.to raise_error
    end

    it "should destroy the users associated address" do 
      user_address = @user.users_address
      @user.destroy
      expect(user_address) != nil
      expect(UsersAddress.where(id: user_address.id)).to be_empty
    end
  end

  describe "order associations" do 
    before do 
      @user.save
    end

    let!(:order_1) do 
      FactoryGirl.create(:order, user: @user)
    end

    let!(:order_2) do 
      FactoryGirl.create(:order, user: @user)
    end

    it "should destroy the assocaited orders" do 
      user_orders = @user.orders.to_a
      @user.destroy
      expect(user_orders).not_to be_empty
      user_orders.each do |order|
        expect(Order.where(id: order.id)).to be_empty
      end
    end
  end
end