require 'spec_helper'

describe Order do
  before do
    @user_1 = FactoryGirl.create(:user)
    @user_1_product_1 = FactoryGirl.create(:product, user: @user_1)
    @user_2_product_2 = FactoryGirl.create(:product, user: @user_1)

    @user_2 = FactoryGirl.create(:user)
    @user_2_product_1 = FactoryGirl.create(:product, user: @user_2)
    @user_2_product_1 = FactoryGirl.create(:product, user: @user_2)

    @user_1_order_1 = FactoryGirl.create(:order, user: @user_1)
  end
  
  subject { @user_1_order_1 }

  it { should respond_to(:user_id) }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @user_1_order_1.user_id = " " }
    it { should_not be_valid }
  end

  describe "user associations" do 
    it "should not allow entrys to be made for users that do not exist" do 
      expect { FactoryGirl.create(:order, user_id: 3) }.to raise_error("Validation failed: User must exist")
    end

    it "should destroy records associated with a user_id when a user is deleted" do
      user_1_order_1 = @user_1.orders
      @user_1.destroy
      expect(user_1_order_1) != nil
      expect(Order.where(id: user_1_order_1.ids)).to be_empty
    end
  end
end