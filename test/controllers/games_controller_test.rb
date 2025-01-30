require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get games_new_url
    assert_response :success
  end

  test "should get create" do
    get games_create_url
    assert_response :success
  end

  test "should get start" do
    get games_start_url
    assert_response :success
  end

  test "should get finish" do
    get games_finish_url
    assert_response :success
  end
end
