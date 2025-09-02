module Match::Resultable
  extend ActiveSupport::Concern

  def winner_id
    if goals_team_1 > goals_team_2
      team_1_id
    elsif goals_team_1 < goals_team_2
      team_2_id
    else
      nil
    end
  end

  def loser_id
    if goals_team_1 < goals_team_2
      team_1_id
    elsif goals_team_1 > goals_team_2
      team_2_id
    else
      nil
    end
  end
end