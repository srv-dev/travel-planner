class DestinationsController < ApplicationController

  def new
  end

  def create
  end

  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find params[:id]

    @hotels_cost = 0
    @current_user.hotels.each do |hotel|
      @hotels_cost += hotel.price if hotel.destination == @destination
    end

    @activities_cost = 0
    @current_user.activities.each do |activity|
      @activities_cost += activity.price if activity.destination == @destination
    end
    
  end

  def edit
    destination = Destination.find params[:id]
    # user = User.find_by params[:id]

    @current_user.destinations  << destination unless @current_user.destinations.include?(destination)

    redirect_to user_path(@current_user.id)
  end

  def update
  end

  def destroy
  end
end
