class MatchesController < ApplicationController
  include Turbo::Broadcastable
  before_action :set_game, only: [:new, :create]

  def new
    # TODO: Add alert message
    return redirect_to root_path if @game.matches.count >= 2
    @match = Match.new
  end
  
  def create
    @match = @game.build_next_match team_ids

    if @match.save
      @game.started! if @game.being_created?

      respond_to do |format|
        format.html { redirect_to @match.game }
        format.turbo_stream if @match.response_type == :turbo_stream
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

    ids
  end

  def match_update_params
    params.require(:match).permit(:goals_team_1, :goals_team_2)
  end
end
