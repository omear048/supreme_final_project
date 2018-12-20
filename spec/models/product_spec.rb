require 'spec_helper'

describe Product do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @product = Product.new(user_id: user.id, title: "Supreme Box Logo",
                      price: 1000, picture_url: "data:image/jpeg;base64,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")
  end

  subject { @product }

  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:picture_url) }
  it { should respond_to(:sold) }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @product.user_id = " " }
    it { should_not be_valid }
    before { @product.user_id = nil }
    it { should_not be_valid }
  end 

  describe "when title is not present" do
    before { @product.title = " " }
    it { should_not be_valid }
    before { @product.title = nil }
    it { should_not be_valid }
  end 

  describe "when price is not present" do
    before { @product.price = " " }
    it { should_not be_valid }
    before { @product.price = nil }
    it { should_not be_valid }
  end 

  describe "when picture_url is not present" do
    before { @product.picture_url = " " }
    it { should_not be_valid }
    before { @product.picture_url = nil }
    it { should_not be_valid }
  end 

  describe "when title too long" do
    before { @product.title = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when price is not a float or integer" do
    before { @product.price = " "}
    it { should_not be_valid }
  end

  describe "when price is less than or equal to 0" do
    before { @product.price = 0 }
    it { should_not be_valid }
  end

  describe "the default value for sold" do
    specify { expect(@product.sold).to eq false }
  end

  describe "users associations" do 
    it "should not allow entrys to be made for users that do not exist" do 
      expect { FactoryGirl.create(:product, user_id: 5) }.to raise_error("Validation failed: User must exist")
    end

    it "should allow multple instances of the same user_id" do 
      FactoryGirl.create(:product, user_id: user.id).should be_valid
    end

    it "should destroy records with an associated user_id when a user is deleted" do 
      FactoryGirl.create(:product, user_id: user.id)

      user_1_listed_products = user.products.to_a
      user.destroy
      expect(user_1_listed_products) != nil
      user_1_listed_products.each do |product|
        expect(Product.where(id: product.id)).to be_empty
      end
    end
  end
end