class PointsController < ApplicationController
  def create
    route = Route.find(params[:route_id])
    point = Point.new
    point.route = route
    point.latitude = params[:latitude]
    point.longitude = params[:longitude]
    point.save!
    render json: { result: 'ok!' }
  end
end
