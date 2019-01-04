require 'spec_helper'

describe UsersAddress do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar").save

    @address = UsersAddress.new(user_id: @user, name: "Kris OMeara", address: "2101 Market Street", 
                                city: "Denver", state: "CO", zip: 80205, phone: "612-247-3127")
  end
  
  subject { @address }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:phone) }
  it { should be_valid }

  describe "when name is not present" do
    before { @address.name = " " }
    it { should_not be_valid }
  end

  describe "when name is over 50 characters" do 
    before { @address.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when address is not present" do 
    before { @address.address = " " }
    it { should_not be_valid } 
  end

  describe "when address is over 250 characters" do
    before { @address.address = "a" * 251 }
    it { should_not be_valid }
  end

  describe "when city is not present" do 
    before { @address.city = " " }
    it { should_not be_valid }
  end

  describe "when state is not present" do
    before { @address.state = " " }
    it { should_not be_valid }
  end

  describe "when zip is not present" do 
    before { @address.zip = " " }
    it { should_not be_valid }
  end

  describe "when zip is not a number" do
    before { @address.zip = "abc" }
    it { should_not be_valid }
  end

  describe "when phone is not present" do 
    before { @address.phone = " " }
    it { should be_valid }
  end

  describe "user associations" do 
    before do 
      @user_2 = FactoryGirl.create(:user)
      @address_user2 = FactoryGirl.create(:users_address, user: @user_2)
    end

    it "should not allow an address to be saved for a user that does not exist" do 
      expect { FactoryGirl.create(:users_address, user_id: 10) }.to raise_error("Validation failed: User must exist")
    end

    it "should not allow a user to have multiple addresses" do 
      expect { FactoryGirl.create(:users_address, user_id: @user_2.id) }.to raise_error("Validation failed: User has already been taken")
    end

    it "should destroy a users associated address when the user is deleted" do
      user2_address = @user_2.users_address
      @user_2.destroy
      expect(user2_address) != nil
      expect(UsersAddress.where(id: user2_address.id)).to be_empty
    end
  end
end
