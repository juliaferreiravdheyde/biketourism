class FavoritesController < ApplicationController
  def index
    @routes = policy_scope(Favorite).map(&:route)
  end

  def create
    @route = Route.find(params[:route_id])
    @favorite = Favorite.create(route: @route, user: current_user)
    authorize @favorite
    redirect_to root_path
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @route = @favorite.route
    @favorite.destroy
    redirect_to root_path
  end
end


# def create
#   route = Route.find(params[:route_id])
#   if current_user.pinned_route == route
#     current_user.update(pinned_route: nil)
#   else
#     current_user.update(pinned_route: route)
#   end
#   redirect_to root_path
# end
