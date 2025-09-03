class PlayersController < ApplicationController
  before_action :set_player, only: [:edit, :update]

  def index
    sort_by = "#{params[:order_by] || :goals}"
    sort_by += "_per_game" if params[:score_type] == "per_game"

    @players = Player
      .includes(teams: [:appearances, :matches])
      .sort_by { |player| player.send(sort_by) }
      .reverse
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to players_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to players_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
