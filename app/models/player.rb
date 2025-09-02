class Player < ApplicationRecord
  has_many :appearances
  has_many :teams, through: :appearances

  def goals
    appearances.sum(:goals)
  end

  def matches_won_count
    teams.includes(:matches).sum(&:matches_won_count)
  end

  def matches_drawn_count
    teams.includes(:matches).sum(&:matches_drawn_count)
  end

  def matches_lost_count
    teams.includes(:matches).sum(&:matches_lost_count)
  end
end
