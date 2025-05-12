module Matches
  class SecondMatch < Match
    validate :different_teams_from_first_match

    def response_type
      :redirect
    end

    private

    def different_teams_from_first_match
      first_match = game.first_match
      same_teams = team_ids.sort == first_match.team_ids.sort

      if same_teams
        errors.add :base, 'V druhom zápase nemôžu hrať rovnaké tímy ako v prvom'
      end
    end
  end
end