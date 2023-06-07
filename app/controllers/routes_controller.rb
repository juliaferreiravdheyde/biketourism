class RoutesController < ApplicationController
  before_action :set_route, only: %i[show destroy edit update record register]

  def index
    @routes = policy_scope(Route)
    @route = Route.new
  end

  def show
    authorize @route
  end

  # def new
  #   @route = Route.new
  #   authorize @route
  # end

  def create
    @route = Route.new
    authorize @route
    @route.creator = current_user
    if @route.save(validate: false)
      redirect_to record_path(@route)
    else
      render :new, error: :unprocessable_entity
    end
  end

  def record
    authorize @route
  end

  def register
    authorize @route
    if @route.points.size < 2
      redirect_to register_path(@route), alert: "Not enough tracking data"
    else
      redirect_to route_path(@route), notice: "Route successfully shared!"
    end
  end

  def destroy
    authorize @route
    @route.destroy
    redirect_to routes_path, notice: "Route succesfully deleted"
  end

  def edit
    authorize @route
  end

  def update
    authorize @route
    if @route.update(route_params)
      redirect_to route_path(@route), notice: "Your route was updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, :description, :type_of_route, :photos, :positive_elevation)
  end
end
