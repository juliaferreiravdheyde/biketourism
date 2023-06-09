class FavoritesController < ApplicationController

  def index
    @routes = Favorite.include(:routes).where(user: current_user)
    raise
  end

  def create
    @route = Route.find(params[:route_id])
    @favorite = Favorite.create(route: @route, user: current_user)
    authorize @favorite
    redirect_to route_path(@route)
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @route = @favorite.route
    @favorite.destroy
    redirect_to route_path(@route)
  end
end
