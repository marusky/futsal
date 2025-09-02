class PagesController < ApplicationController
  def home
    @games = Game.order(created_at: :desc)
  end

  def statistics
    @service = StatisticsService.new(Game.pluck(:id))
    @players = Player.includes(:appearances).order(:name)
  end

  def charts
    @data = []
    Player.all.each do |player|
      data = {}

      Game.all.each do |game|
        service = StatisticsService.new([game.id])
        data[game.created_at.strftime('%d. %m.')] = service.absolute_goals_for_player(player)
      end

      @data << { 
        name: player.name,
        data:
      }
    end
  end
end
