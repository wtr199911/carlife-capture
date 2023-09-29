require "test_helper"

class Public::GroupUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_group_users_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_group_users_destroy_url
    assert_response :success
  end
end
