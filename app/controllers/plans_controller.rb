class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trips, only: %i[index]
  
  def index
    # raise @trips.inspect
  end


  def show
  end

  def create

    @plan = Plan.new(plans_params)
    # raise @trip.inspect
    respond_to do |format|
      if @plan.save
        format.html { redirect_to trips_url(@plan), notice: "Sucesso" }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
  end

  def show_create
  end

  private

  def set_trips
    @trips = Trip.where(user_id: current_user.id)
  end

  def plans_params
    params[:plan] ||= params
    params[:plan][:trip_id] ||= trip.id
    params.require(:plan).permit(:title, :date, :budget, hotel, description)
  end


end