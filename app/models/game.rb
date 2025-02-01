class Game < ApplicationRecord
  has_many :matches, dependent: :delete_all
  has_many :teams, dependent: :destroy

  enum :status, {
    being_created: 0,
    started: 1,
    finished: 2,
  }, default: :being_created
end
