class UsersController < ApplicationController

  before_action :check_if_logged_in, only: [:edit, :update]
  # before_action :check_if_admin, only: [:index]
  def new
    @user = User.new
  end

  def create
    @user = User.create user_params # strong params
    if @user.persisted?
      # Account created successfully
      session[:user_id] = @user.id # Log in automatically!
      redirect_to user_path(@user.id)
    else
      render :new
    end # if
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]

    # Code to pass destinations array to Map
    @marker_arr = []
    @user.destinations.each do |destination|
      if destination.latitude && destination.longitude
        @marker_arr << {"title" => destination.name, "lat" => destination.latitude, "lng" => destination.longitude}
      end
    end

  end

  def destroy
    puts "*************** #{params[:id]}"
    destination = Destination.find params[:id]
    destination.users.destroy @current_user.id

    redirect_to user_path(@current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
