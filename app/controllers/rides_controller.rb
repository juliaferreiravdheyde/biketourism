class RidesController < ApplicationController
  before_action :set_ride, only: %i[destroy mark_as_done]

  def mark_as_done
    @ride.done!
    @route = Route.find(params[:route_id])
     respond_to do |format|
       format.html {redirect_to @route}
       format.json {head :no_content}
    end
    authorize @ride
  end

  def create
    @ride = Ride.new
    @route = Route.find(params[:route_id])
    @ride.route = @route
    @ride.time = 30
    @ride.user = current_user
    authorize @ride
  if @ride.save
    redirect_to route_path(@route)
  else
    render :new, error: :unprocessable_entity
  end
  end

  def destroy
    authorize @ride
    @ride.destroy
    redirect_to route_path(@ride.route), notice: "Ride succesfully deleted"
  end

  private

  def set_ride
    @ride = Ride.find(params[:id])
  end

  # def ride_params
  #   params.require(:ride).permit()
  # end
end
