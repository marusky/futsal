class Game < ApplicationRecord
  has_many :matches, dependent: :delete_all
  has_many :teams, dependent: :destroy

  # TODO broadcast game starting and finishing
  # after_update_commit -> do 
  #   broadcast_replace_to :games 
  # end, if: :saved_change_to_status?

  enum :status, {
    being_created: 0,
    started: 1,
    finished: 2,
  }, default: :being_created

  def three_teams?
    teams.count == 3
  end
end
