class RoutesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_route, only: %i[show destroy edit update record register]

  def index
    @routes = Route.all
    @address = ""
    @distance = 0
    @type_of_route = nil

    if params[:search].present?
      @address = params[:search][:address]
      @distance =  params[:search][:distance].to_i
      @type_of_route = params[:search][:type_of_route]

      @routes = @routes.where("distance <= ?", @distance * 1000 ) if @distance.present? && @distance > 0
      @routes = @routes.where(type_of_route: @type_of_route ) if @type_of_route.present?
      if @address.present?
        points = Point.near(@address, 10)
        @routes = @routes.where(id: points.map(&:route).pluck(:id).uniq) if points.present?
      end
    end
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
    respond_to do |format|
      if @route.points.empty?
        format.html
        format.text { render partial: "shared/map", locals: { markers: @markers, height: "300px", html_options: { class: 'd-none' } }, formats: [:html] }
      else
        @markers = @route.points.map { |point| { lat: point.latitude, lng: point.longitude } }
        format.html
        format.text { render partial: "shared/map", locals: { markers: @markers, height: "300px", html_options: { class: '' } }, formats: [:html] }
      end
    end
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

  # # Build the SQL query using ActiveRecord syntax
  # query = <<-SQL
  #   SELECT DISTINCT routes.*
  #   FROM routes
  #   INNER JOIN points ON points.route_id = routes.id
  #   WHERE (
    #     2 * 6371 * asin(
      #       sqrt(
        #         sin((radians(points.latitude) - radians(?)) / 2) * sin((radians(points.latitude) - radians(?)) / 2) +
        #         cos(radians(?)) * cos(radians(points.latitude)) *
        #         sin((radians(points.longitude) - radians(?)) / 2) * sin((radians(points.longitude) - radians(?)) / 2)
        #       )
        #     )
        #   ) <= ?
        # SQL

        # # Execute the query using ActiveRecord
        # routes_within_radius = Route.find_by_sql([query, user_latitude, user_latitude, user_latitude, user_longitude, user_longitude, radius_km])

      end

      #   if @address.present? && (params[:search][:distance] == "0") && !(@type_of_route.present?)
      #     address = params[:search][:address]
      #     coordinates = Geocoder.coordinates(address)
      #     latitude = coordinates[0]
      #     longitude = coordinates[1]
      #     radius = 10
      #     query = <<-SQL
      #       SELECT DISTINCT routes.*
      #       FROM routes
      #       INNER JOIN points ON points.route_id = routes.id
      #       WHERE (
      #       2 * 6371 * asin(
      #         sqrt(
      #           sin((radians(points.latitude) - radians(?)) / 2) * sin((radians(points.latitude) - radians(?)) / 2) +
      #           cos(radians(?)) * cos(radians(points.latitude)) *
      #             sin((radians(points.longitude) - radians(?)) / 2) * sin((radians(points.longitude) - radians(?)) / 2)
      #             )
      #           )
      #         ) <= ?
      #     SQL
      #     #   # Execute the query using ActiveRecord
      #     @routes = policy_scope(Route).find_by_sql([query, latitude, latitude, latitude, longitude, longitude, radius])
      #   elsif params[:search][:distance] != "0" && !(params[:search][:address].present?) && !(params[:search][:type_of_route].present?)
