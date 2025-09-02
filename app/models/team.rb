class Team < ApplicationRecord
  belongs_to :game
  has_many :matches, through: :game

  has_many :appearances, dependent: :destroy
  has_many :players, through: :appearances, dependent: :destroy

  validates :name, presence: true
  validate :at_least_three_players

  def matches_won_count
    matches.filter { |match| match.winner_id == id }.count
  end

  def matches_drawn_count
    matches.filter { |match| match.winner_id == nil }.count
  end

  def matches_lost_count
    matches.filter { |match| match.loser_id == id }.count
  end

  private

  def at_least_three_players
    return if players.size >= 3

    errors.add :players, 'Tím musí mať aspoň troch hráčov'
  end
end
