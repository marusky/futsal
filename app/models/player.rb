class Player < ApplicationRecord
  has_many :appearances
  has_many :teams, through: :appearances

  def goals
    appearances.sum(&:goals)
  end

  def goals_per_game
    return 0 if appearances.none?

    (appearances.sum(&:goals).to_f / appearances.size).round(2)
  end

  def wins
    teams.sum(&:matches_won_count)
  end

  def wins_per_game
    return 0 if appearances.none?

    (wins.to_f / appearances.size).round(2)
  end

  def draws
    teams.sum(&:matches_drawn_count)
  end

  def draws_per_game
    return 0 if appearances.none?

    (draws.to_f / appearances.size).round(2)
  end

  def losses
    teams.sum(&:matches_lost_count)
  end

  def losses_per_game
    return 0 if appearances.none?

    (losses.to_f / appearances.size).round(2)
  end
end
