module Matches
  class FollowingMatch < Match
    before_validation :pick_teams

    def response_type
      :turbo_stream
    end

    private

    def pick_teams
      team_ids = game.first_round_team_ids[corresponding_match_index]
      team_ids = team_ids.reverse if game_round.even?

      assign_team_ids team_ids
    end

    def corresponding_match_index
      match_index % Game::MATCHES_PER_ROUND
    end
    
    def game_round
      (match_index / Game::MATCHES_PER_ROUND) + 1
    end

    def match_index
      @_match_index ||= game.matches.count
    end
  end
end