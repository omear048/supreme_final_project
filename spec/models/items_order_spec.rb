require 'spec_helper'

describe ItemsOrder do
  before do
    @user_1 = FactoryGirl.create(:user)
    @user_1_product_1 = FactoryGirl.create(:product, user: @user_1)
    @user_2_product_2 = FactoryGirl.create(:product, user: @user_1)

    @user_2 = FactoryGirl.create(:user)
    @user_2_product_1 = FactoryGirl.create(:product, user: @user_2)
    @user_2_product_1 = FactoryGirl.create(:product, user: @user_2)

    @user_1_order_1 = FactoryGirl.create(:order, user: @user_1)
    @user_1_order_2 = FactoryGirl.create(:order, user: @user_1)

    @user_1_order_1_items_orders_1 = FactoryGirl.create(:items_order, order: @user_1_order_1, product: @user_2_product_1)
    @user_1_order_1_items_orders_2 = FactoryGirl.create(:items_order, order: @user_1_order_1, product: @user_2_product_2)
  end
  
  subject { @user_1_order_1_items_orders_1 }

  it { should respond_to(:order_id) }
  it { should respond_to(:product_id) }
  it { should be_valid }

  describe "when order_id is not present" do
    before { @user_1_order_1_items_orders_1.order_id = " " }
    it { should_not be_valid }
  end

  describe "when product_id is not present" do 
    before { @user_1_order_1_items_orders_1.product_id = " " }
    it { should_not be_valid }
  end

  describe "order associations" do 
    it "should not allow entrys to be made for orders that do not exist" do 
      expect { FactoryGirl.create(:items_order, order_id: 10, product: @user_1_product_1) }.to raise_error("Validation failed: Order must exist")
    end

    it "should allow multiple instances of the same order_id" do 
      FactoryGirl.create(:items_order, order: @user_1_order_1, product: @user_1_product_1).should be_valid
    end

    it "should destroy records with an associated order_id when an order is deleted" do
      user_1_order_1_items_orders_1 = @user_1_order_1.items_orders.to_a
      @user_1_order_1.destroy
      expect(user_1_order_1_items_orders_1) != nil
      user_1_order_1_items_orders_1.each do |item|
        expect(ItemsOrder.where(id: item.id)).to be_empty
      end
    end
  end

  describe "order and product associations" do 
    it "should not allow entrys to be made for products that do not exist" do
      expect { FactoryGirl.create(:items_order, order: @user_1_order_1, product_id: 10) }.to raise_error("Validation failed: Product must exist")
    end

    it "should not allow multiple instances of the same product_id" do 
      expect { FactoryGirl.create(:items_order, order: @user_1_order_2, product: @user_2_product_1) }.to raise_error("Validation failed: Product has already been taken")
    end
  end
end
