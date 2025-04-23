class Team < ApplicationRecord
  belongs_to :game

  has_many :appearances, dependent: :destroy
  has_many :players, through: :appearances, dependent: :destroy

  validates :name, presence: true
  validate :at_least_three_players

  private

  def at_least_three_players
    return if players.size >= 3

    errors.add :players, 'Tím musí mať aspoň troch hráčov'
  end
end
