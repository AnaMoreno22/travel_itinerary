class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trips, only: %i[index]
  before_action :set_trip, only: %i[show destroy]
  
  def index
  end


  def show
    @plans = Plan.where(trip_id: @trip.id)
  end

  def destroy
    @trip.destroy
    render body: @trips
  end

  def create
    @trip = Trip.new(trip_params)
    # raise @trip.inspect
    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_url(@trip), notice: "Sucesso" }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
  end

  def show_create
  end

  private

  def set_trips
    @trips = Trip.where(user_id: current_user.id).where("title != ?", "")
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
  

  def trip_params
    params[:trip] ||= params
    params[:trip][:user_id] ||= current_user.id
    params.require(:trip).permit(:title, :date, :user_id)
  end


end