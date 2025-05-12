module Match::Resultable
  extend ActiveSupport::Concern

  def winner
    if goals_team_1 > goals_team_2
      team_1
    elsif goals_team_1 < goals_team_2
      team_2
    else
      nil
    end
  end

  def loser
    if goals_team_1 < goals_team_2
      team_1
    elsif goals_team_1 > goals_team_2
      team_2
    else
      nil
    end
  end
end