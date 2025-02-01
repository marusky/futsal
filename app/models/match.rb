class Match < ApplicationRecord
  belongs_to :game
  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'

  after_update_commit -> { broadcast_replace_to :matches }

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
