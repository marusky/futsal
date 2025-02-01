require "test_helper"

class AppearancesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get appearances_update_url
    assert_response :success
  end
end
