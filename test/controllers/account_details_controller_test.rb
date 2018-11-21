require 'test_helper'

class AccountDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get controller" do
    get account_details_controller_url
    assert_response :success
  end

  test "should get address" do
    get account_details_address_url
    assert_response :success
  end

  test "should get orders" do
    get account_details_orders_url
    assert_response :success
  end

end
