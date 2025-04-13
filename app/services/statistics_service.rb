class StatisticsService
  def initialize(game_ids)
    @game_ids = game_ids
    @matches = Match.where(game_id: game_ids)
  end

  def absolute_goals_for_player(player)
    Appearance
      .joins(:team)
      .where(player_id: player.id, team: { game_id: @game_ids })
      .sum(:goals)
  end

  def relative_goals_for_player(player)
    return '-' unless players_appearances_count.fetch(player.id, 0).positive?

    (absolute_goals_for_player(player) / players_appearances_count[player.id].to_f).round(2)
  end

  def absolute_score_for_player(player, type)
    team_scores
      .values_at(*players_team_ids[player.id])
      .sum { |score| score[type] }
  end

  def relative_score_for_player(player, type)
    return '-' unless appearances_for_player(player).positive?

    (absolute_score_for_player(player, type) / players_appearances_count[player.id].to_f).round(2)
  end

  def teams_scores_presentable
    Team.where(id: team_scores.keys).map do |team|
      { 
        name: team.name,
        points: 3 * team_scores[team.id][:wins] + team_scores[team.id][:draws],
      }
    end.sort { |team_obj| team_obj[:points] }.reverse
  end

  private

  def team_scores
    return @_team_scores if defined?(@_team_scores)

    @_team_scores = {}
    @matches.each do |match|
      @_team_scores[match.team_1_id] ||= { wins: 0, draws: 0, loses: 0 }
      @_team_scores[match.team_2_id] ||= { wins: 0, draws: 0, loses: 0 }

      if match.goals_team_1 == match.goals_team_2
        @_team_scores[match.team_1_id][:draws] += 1
        @_team_scores[match.team_2_id][:draws] += 1
      else
        @_team_scores[match.winner.id][:wins] += 1
        @_team_scores[match.loser.id][:loses] += 1
      end
    end

    @_team_scores
  end

  def players_team_ids
    @_players_team_ids ||= Appearance
      .joins(team: :game)
      .includes(:player)
      .where(game: { id: @game_ids })
      .select(:player_id, team: { id: :team_id })
      .group_by(&:player_id)
      .transform_values { |records| records.map(&:team_id) }
  end

  def appearances_for_player(player)
    players_appearances_count.fetch(player.id, 0)
  end

  def players_appearances_count
    @_players_appearances_count ||= Appearance.group(:player_id).count
  end
end