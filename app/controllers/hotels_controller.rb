class HotelsController < ApplicationController
  def new
  end

  def create
    hotel = Hotel.find params[:format]
    @current_user.hotels << hotel unless @current_user.hotels.include?(hotel)

    redirect_to destination_path(hotel.destination.id)
  end

  def index
  end

  def show
    @destination = Destination.find params[:id]

  end

  def edit
  end

  def update
  end

  def destroy
    hotel = Hotel.find params[:id]

    @current_user.hotels.destroy params[:format] unless @current_user.hotels.include?(hotel)

    redirect_to destination_path(hotel.destination.id)
  end
end
