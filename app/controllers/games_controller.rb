class GamesController < ApplicationController
  helper_method :is_game_creator?
  before_action :set_game, only: [:show, :matches, :appearances, :start, :finish]

  def show
  end

  def create
    return unless Game.being_created.empty?
    
    @game = Game.create
    cookies[:game_sgid] = @game.to_sgid

    redirect_to @game
  end

  def matches
    @matches = @game.matches.order(:created_at).includes(:team_1, :team_2)
  end

  def appearances
    # TODO: this will be wrong
    player_ids = @game.teams.map(&:player_ids).flatten

    @players = Player.where(id: player_ids)
  end

  def start
    @game.started!

    redirect_to new_match_url(game_id: @game.id)
  end
  
  def finish
    @game.finished!

    redirect_to root_url
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def is_game_creator?(game)
    game === GlobalID::Locator.locate_signed(cookies[:game_sgid])
  end
end
