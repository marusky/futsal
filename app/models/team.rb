class Team < ApplicationRecord
  belongs_to :game

  has_many :appearances
  has_many :players, through: :appearances, dependent: :destroy
end
