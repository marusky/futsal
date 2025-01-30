class Game < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :matches, dependent: :delete_all

  enum :status, {
    being_created: 0,
    started: 1,
    finished: 2,
  }, default: :being_created
end
