class RoutesController < ApplicationController
  before_action :set_routes, only: %i[ show ]

  def index
    @routes = Route.all
  end

  def show
    @ride = Ride.new
  end

  private

  def set_routes
    @route = Route.find(params[:id])
  end
end
