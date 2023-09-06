require "test_helper"

class Admin::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get genres" do
    get admin_customers_genres_url
    assert_response :success
  end

  test "should get posts" do
    get admin_customers_posts_url
    assert_response :success
  end
end
