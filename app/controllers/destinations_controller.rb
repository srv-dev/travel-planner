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
