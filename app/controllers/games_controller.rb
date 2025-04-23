class GamesController < ApplicationController
  helper_method :is_game_creator?
  before_action :set_game, only: [:show, :matches, :appearances, :start, :finish]

  def show
    if @game.started?
      @matches = @game.matches.order(:created_at).includes(:team_1, :team_2)
      @appearances = 
        Appearance
          .joins(team: :game)
          .includes(:player)
          .where(game: { id: @game.id })
          .order(:team_id)
    elsif @game.finished?
      @service = StatisticsService.new([@game.id])
      @players = Player
        .joins(:teams)
        .where(teams: { game: @game })
      @appearances = 
        Appearance
          .joins(team: :game)
          .includes(:player)
          .where(game: { id: @game.id })
          .order(:team_id)
    end
  end

  def create
    return redirect_to Game.being_created.first if Game.being_created.exists?
    
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

  def scores
    @team_points = @game.team_ids.zip([0,0,0]).to_h
    @matches.each do |match|
      if match.goals_team_1 == match.goals_team_2
        @team_points[match.team_1_id] += 1
        @team_points[match.team_2_id] += 1
      else
        @team_points[match.winner.id] += 3
      end
    end
  end
end
