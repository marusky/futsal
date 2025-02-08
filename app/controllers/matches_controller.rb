class MatchesController < ApplicationController
  include Turbo::Broadcastable
  before_action :set_game, only: [:new, :create]

  def new
    # TODO: Add alert message
    return redirect_to root_path if @game.matches.count >= 2
    @match = Match.new
  end
  
  def create
    match_service = MatchService.new(game: @game, team_ids:)
    @match = match_service.new_match

    if @match.save
      @game.started!
      return redirect_to @match.game if match_service.teams_selected_by_user?

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
