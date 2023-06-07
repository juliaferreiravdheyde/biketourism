class RoutesController < ApplicationController
  before_action :set_route, only: %i[show destroy edit update]

  def index
    @routes = Route.all
  end

  def show
    @ride = Ride.new
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)
    @route.creator = current_user
    if @route.save!
      redirect_to routes_path
    else
      render :new, error: :unprocessable_entity
    end
  end

  def destroy
    @route.destroy
    redirect_to routes_path, notice: "Route succesfully deleted"
    authorize @route
  end

  def edit
  end

  def update
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, :description, :type_of_route, :photos, :positive_elevation)
  end
end
