class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update]
  def new
    @team = Team.new(game_id: params[:game_id])
  end

  def create
    @team = Team.new(team_params)
    
    if @team.save
      redirect_to @team.game
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team.game
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :game_id, player_ids: [])
  end
end
