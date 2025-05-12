module Game::Matchable
  extend ActiveSupport::Concern

  included do
    has_many :matches, dependent: :delete_all
  end

  MATCHES_PER_ROUND = 3

  def build_next_match(team_ids = nil)
    case matches.count
    when 0
      Matches::FirstMatch.new(game: self).assign_team_ids(team_ids)
    when 1
      Matches::SecondMatch.new(game: self).assign_team_ids(team_ids)
    when 2
      Matches::ThirdMatch.new(game: self)
    when (3..)
      Matches::FollowingMatch.new(game: self)
    end
  end

  def first_match
    matches.first
  end

  def team_id_with_multiple_matches_played
    seen = Set.new
    played_by_team_ids = matches.pluck(:team_1_id, :team_2_id).flatten
    
    played_by_team_ids.find { |team_id| !seen.add? team_id }
  end

  def first_round_team_ids
    matches.first(Game::MATCHES_PER_ROUND).pluck(:team_1_id, :team_2_id)
  end
end