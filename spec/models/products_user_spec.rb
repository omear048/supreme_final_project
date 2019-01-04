require 'spec_helper'

describe UsersAddress do
  before do
    @user_1 = FactoryGirl.create(:user)
    @user_1_product_1 = FactoryGirl.create(:product, user: @user_1)
    @user_2_product_2 = FactoryGirl.create(:product, user: @user_1)

    @user_2 = FactoryGirl.create(:user)
    @user_2_product_1 = FactoryGirl.create(:product, user: @user_2)
    @user_2_product_1 = FactoryGirl.create(:product, user: @user_2)

    @user_2_products_users_entry_1 = FactoryGirl.create(:products_user, user: @user_1, product: @user_2_product_1)
  end
  
  subject { @user_2_products_users_entry_1 }

  it { should respond_to(:user_id) }
  it { should respond_to(:product_id) }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @user_2_products_users_entry_1.user_id = " " }
    it { should_not be_valid }
  end

  describe "when product_id is not present" do 
    before { @user_2_products_users_entry_1.product_id = " " }
    it { should_not be_valid }
  end

  describe "unique product + user record combinations" do
    it "should not allow multiple entrys of the same product_id + user_id combination" do
      expect { FactoryGirl.create(:products_user, user: @user_1, product: @user_2_product_1) }.to raise_error("Validation failed: User has already been taken")
    end
  end

  describe "user associations" do 
    it "should not allow entrys to be made for users that do not exist" do 
      expect { FactoryGirl.create(:products_user, user_id: 3, product: @user_1_product_1) }.to raise_error("Validation failed: User must exist")
    end

    it "should allow multiple entrys with the same user_id to be made" do 
      FactoryGirl.create(:products_user, user_id: @user_1.id, product: @user_1_product_1).should be_valid
    end

    it "should destroy records with an associated user_id records when a user is deleted" do
      cart_entry_1 = @user_1.products_users
      @user_1.destroy
      expect(cart_entry_1) != nil
      expect(ProductsUser.where(id: cart_entry_1.ids)).to be_empty
    end
  end

  describe "product associations" do 
    it "should not allow entrys to be made for products that do not exist" do 
      expect { FactoryGirl.create(:products_user, user: @user_2, product_id: 5) }.to raise_error("Validation failed: Product must exist")
    end

    it "should allow multiple entrys with the same product_id to be made" do 
      FactoryGirl.create(:products_user, user_id: @user_2.id, product: @user_2_product_1).should be_valid
    end

    it "should destroy records with an associated product_id when a product is deleted" do 
      cart_entry_1 = @user_2_product_1.products_users
      @user_2_product_1.destroy
      expect(cart_entry_1) != nil
      expect(ProductsUser.where(id: cart_entry_1.ids)).to be_empty
    end
  end
end
