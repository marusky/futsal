class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    
    if @team.save
      redirect_to @team.game
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:name, :game_id, player_ids: [])
  end
end
