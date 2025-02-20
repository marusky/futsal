class PagesController < ApplicationController
  def home
    @games = Game.all
  end

  def statistics
    @service = StatisticsService.new(Game.pluck(:id))
    @players = Player.includes(:appearances).order(:name)
  end
end
