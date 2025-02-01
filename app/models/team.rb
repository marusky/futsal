class Team < ApplicationRecord
  belongs_to :game

  has_many :appearances, dependent: :destroy
  has_many :players, through: :appearances, dependent: :destroy
end
