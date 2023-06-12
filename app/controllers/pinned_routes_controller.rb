class PinnedRoutesController < ApplicationController

  # def create
  #   route = Route.find(params[:route_id])
  #   current_user.update(pinned_route: route)
  #   redirect_to root_path
  # end

  def index
    @routes = current_user.pinned_route.present? ? [current_user.pinned_route] : []
  end

  def create
    @route = Route.find(params[:route_id])
    current_user.update(pinned_route: @route)
    redirect_to route_path(@route)
  end

  def destroy
    current_user.update(pinned_route: nil)
    redirect_to root_path
  end
end
