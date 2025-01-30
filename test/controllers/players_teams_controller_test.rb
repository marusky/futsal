require "test_helper"

class PlayersTeamsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get players_teams_update_url
    assert_response :success
  end
end
