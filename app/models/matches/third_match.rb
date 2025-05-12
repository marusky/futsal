module Matches
  class ThirdMatch < Match
    before_validation :pick_teams_that_did_not_play

    def response_type
      :turbo_stream
    end

    private

    def pick_teams_that_did_not_play
      team_ids = game.team_ids - [game.team_id_with_multiple_matches_played]

      assign_team_ids team_ids
    end
  end
end