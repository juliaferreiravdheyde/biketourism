class PinnedRoutesController < ApplicationController
  def create
    route = Route.find(params[:route_id])
    if current_user.pinned_route == route
      current_user.update(pinned_route: nil)
    else
      current_user.update(pinned_route: route)
    end
    redirect_to root_path
  end
end
