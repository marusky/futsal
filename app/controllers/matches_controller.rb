class MatchesController < ApplicationController
  before_action :set_game, only: [:new, :create]

  def new
    @match = Match.new
  end
  
  def create
    @match = MatchService.new(game: @game, team_ids:).new_match

    if @match.save
      redirect_to matches_game_url(@match.game)    
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @match = Match.find(params[:id])

    if @match.update(match_update_params)
      respond_to do |format|
        format.html { redirect_to live_game_url(@match.game) }
        format.turbo_stream
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def team_ids
    return if params[:team_ids].nil?

    params[:team_ids].reject!(&:empty?)

    { team_1_id: params[:team_ids][0], team_2_id: params[:team_ids][1] }
  end

  def match_update_params
    params.require(:match).permit(:goals_team_1, :goals_team_2)
  end
end
