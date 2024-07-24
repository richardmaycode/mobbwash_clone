require "test_helper"

class Admin::VendorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_vendors_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_vendors_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_vendors_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_vendors_edit_url
    assert_response :success
  end

  test "should get delete" do
    get admin_vendors_delete_url
    assert_response :success
  end
end
