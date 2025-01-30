class Player < ApplicationRecord
  has_many :appearances
  has_many :teams, through: :appearances
end
