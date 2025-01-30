class PlayersController < ApplicationController
  def index
    @players = Player.order(:name)
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
    @Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
