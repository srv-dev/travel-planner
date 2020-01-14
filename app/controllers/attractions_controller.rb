class AttractionsController < ApplicationController
  def new
  end

  def create
    attraction = Attraction.find params[:format]
    @current_user.attractions << attraction unless @current_user.attractions.include?(attraction)

    redirect_to destination_path(attraction.destination.id)
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
    
  end
end
