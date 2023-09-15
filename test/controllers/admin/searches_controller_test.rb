require "test_helper"

class Admin::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get public/searches" do
    get admin_searches_public/searches_url
    assert_response :success
  end
end
