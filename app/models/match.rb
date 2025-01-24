class Match < ApplicationRecord
  belongs_to :game
  belongs_to :team_1
  belongs_to :team_2
end
