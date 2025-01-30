class MatchService
  def initialize(game:, team_ids:)
    @game = game
    @team_ids = team_ids
  end

  def new_match
    matches_count = @game.matches.count

    if matches_count == 2
      played_by_team_ids = @game.matches.pluck(:team_1_id, :team_2_id).flatten
      seen = Set.new
      played_twice = played_by_team_ids.select { |el| !seen.add?(el) }

      @team_ids = serialized_team_ids(@game.team_ids - played_twice)
    elsif matches_count > 2
      @team_ids = serialized_team_ids(
        @game
          .matches
          .order(:created_at)
          .first(3)
          .pluck(:team_1_id, :team_2_id)[matches_count % 3],
        matches_count
      )
    end

    @match = @game.matches.build(@team_ids)
  end

  private

  def serialized_team_ids(team_ids, matches_count = 2)
    { 
      team_1_id: team_ids[(matches_count / 3) % 2],
      team_2_id: team_ids[((matches_count + 3) / 3) % 2]
    }
  end
end