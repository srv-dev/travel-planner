class ActivitiesController < ApplicationController
  def new
  end

  def create
    activity = Activity.find params[:format]
    @current_user.activities << activity unless @current_user.activities.include?(activity)

    redirect_to destination_path(activity.destination.id)
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
