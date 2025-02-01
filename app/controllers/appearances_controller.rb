class AppearancesController < ApplicationController
  def update
    @appearance = Appearance.find(params[:id])

    @appearance.update!(appearances_params)
  end

  private

  def appearances_params
    params.require(:appearance).permit(:goals)
  end
end
