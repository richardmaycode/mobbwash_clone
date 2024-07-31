require "test_helper"

class Customer::FulfillmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customer_fulfillments_show_url
    assert_response :success
  end
end
