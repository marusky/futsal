class Game < ApplicationRecord
  include Matchable

  has_many :teams, dependent: :destroy

  enum :status, {
    being_created: 0,
    started: 1,
    finished: 2,
  }, default: :being_created

  def three_teams?
    teams.count == 3
  end
end
