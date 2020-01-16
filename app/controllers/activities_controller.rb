class ActivitiesController < ApplicationController

  def create
    activity = Activity.find params[:format]
    @current_user.activities << activity unless @current_user.activities.include?(activity)

    redirect_to destination_path(activity.destination.id)
  end

  def show
    @destination = Destination.find params[:id]
  end

  def destroy
    activity = Activity.find params[:id]

    activity.users.destroy @current_user

    redirect_to destination_path(activity.destination.id)
  end
  
end
