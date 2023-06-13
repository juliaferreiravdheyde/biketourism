class RoutesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_route, only: %i[show destroy edit update record register]

  def index
    @routes = policy_scope(Route).where.not(name: nil)
    @route = Route.new
  end

  def show
    authorize @route
    @ride = Ride.new
    @ride_on_going = Ride.where(done: false).where(user: current_user)
    @favorite = Favorite.where(route: @route, user: current_user)
    @markers = @route.points.map do |point|
      {
        lat: point.latitude,
        lng: point.longitude
      }
    end
  end

  def create
    @route = Route.new
    authorize @route
    @route.creator = current_user
    # destroy incompleted routes
    Route.where(creator: current_user).where(name: nil).each(&:destroy)
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
    @route.distance = @route.total_distance
    if @route.points.size < 2
      redirect_to register_path(@route), alert: "Not enough tracking data"
    elsif @route.update(route_params)
      redirect_to route_path(@route), notice: "Route successfully shared!"
    else
      render :record, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @route
    @route.destroy
    redirect_to routes_path, notice: "Route succesfully deleted"
  end

  def delete_image_attachment
    @route_photo = ActiveStorage::Attachment.find(params[:id])
    @route_photo.purge
    redirect_back(fallback_location: request.referer)
  end

  def edit
    authorize @route
    @route.photos.build if @route.photos.blank?
  end

  def update
    authorize @route
    if params[:route][:photos].present?
      @route.photos.attach(params[:route][:photos])
    end
    if @route.update(route_params.except('photos'))
      redirect_to route_path(@route), notice: "Your route was updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def update
  #   if @route.save?
  #     redirect_to route_path(@route)
  #   else
  #     render :edit, error: :unprocessable_entity
  #   end
  # end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, :description, :distance, :type_of_route, :positive_elevation, photos: [])
  end
end
