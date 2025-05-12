class Match < ApplicationRecord
  include Resultable

  belongs_to :game
  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'

  after_update_commit -> { broadcast_replace_to :matches, partial: 'matches/match', locals: { match: self } }
  after_create_commit -> { broadcast_append_to :matches, partial: 'matches/match', locals: { match: self } }

  def assign_team_ids(team_ids)
    self.team_1_id, self.team_2_id = team_ids

    self
  end

  def response_type
    raise NotImplementedError, "#{self.class.name} must implement #response_type"
  end

  protected

  def team_ids
    [team_1_id, team_2_id]
  end
end
