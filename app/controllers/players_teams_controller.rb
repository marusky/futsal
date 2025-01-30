class PlayersTeamsController < ApplicationController
  def update
    ActiveRecord::Base.connection.execute(
      "UPDATE 'players_teams' SET 'goals' = #{params[:goals]} WHERE 'players_teams'.'player_id' = #{params[:player_id]} AND 'players_teams'.'team_id' = #{params[:team_id]}"
    )

    @game = Game.find(params[:game_id])
    redirect_to goals_game_url(@game)
  end
end
