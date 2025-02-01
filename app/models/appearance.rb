class Appearance < ApplicationRecord
  belongs_to :player
  belongs_to :team

  delegate :name, to: :player

  after_update_commit -> do 
    broadcast_replace_to :appearances
  end
end
