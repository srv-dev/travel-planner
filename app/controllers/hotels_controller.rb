class HotelsController < ApplicationController

  def create
    hotel = Hotel.find params[:format]
    @current_user.hotels << hotel unless @current_user.hotels.include?(hotel)

    redirect_to destination_path(hotel.destination.id)
  end

  def show
    @destination = Destination.find params[:id]
  end

  def destroy
    hotel = Hotel.find params[:id]

    hotel.users.destroy @current_user

    redirect_to destination_path(hotel.destination.id)
  end
end
