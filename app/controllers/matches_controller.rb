class MatchesController < ApplicationController
  before_action :set_game, only: [:new, :create]

  def new
    @match = Match.new
  end
  
  def create
    @match = MatchService.new(game: @game, team_ids:).new_match

    if @match.save
      respond_to do |format|
        format.html { redirect_to @match.game }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @match = Match.find(params[:id])

    if @match.update(match_update_params)
      respond_to do |format|
        format.html { redirect_to @game }
        format.turbo_stream
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def team_ids
    ids = params.keys.map{ |key| key.delete_prefix 'team_id_' if key.to_s.start_with? 'team_id_' }.compact
    return unless ids.count == 2

    { team_1_id: ids[0], team_2_id: ids[1] }
  end

  def match_update_params
    params.require(:match).permit(:goals_team_1, :goals_team_2)
  end
end
