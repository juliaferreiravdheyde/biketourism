class FavoritesController < ApplicationController
  def index
    @routes = policy_scope(Favorite).map(&:route)
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
