class RoutesController < ApplicationController
  before_action :set_route, only: %i[show destroy edit update]

  def index
    @routes = policy_scope(Route)
  end

  def show
    authorize @route
  end

  def new
    @route = Route.new
    authorize @route
  end

  def create
    @route = Route.new(route_params)
    authorize @route
    @route.creator = current_user
    if @route.save!
      redirect_to route_path(@route)
    else
      render :new, error: :unprocessable_entity
    end
    authorize @route
  end

  def destroy
    authorize @route
    @route.destroy
    redirect_to routes_path, notice: "Route succesfully deleted"
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
