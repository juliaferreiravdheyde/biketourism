class RoutesController < ApplicationController
  before_action :set_routes, only: %i[show]

  def index
    @routes = Route.all
  end

  def show
    @ride = Ride.new
    authorize @route
  end

  def new
    @route = Route.new
    authorize @route
  end

  def create
    @route = Route.new(route_params)
    @route.creator = current_user
    if @route.save!
      redirect_to routes_path
    else
      render :new, error: :unprocessable_entity
    end
    authorize @route
  end

  private

  def set_routes
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, :description, :type_of_route, :photos, :positive_elevation)
  end
end
