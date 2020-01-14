class ApplicationController < ActionController::Base

  before_action :fetch_user


  def fetch_user

    if session[:user_id].present?
      @current_user = User.find_by id: session[:user_id]
    end

    unless @current_user.present?
      session[:user_id] = nil
    end
  end # fetch_user

  def check_if_logged_in
    # Show pages can only be seen by logged-in Users
    redirect_to login_path unless @current_user.present?
  end

  def check_if_admin
    redirect_to login_path unless @current_user.present? && @current_user.admin?
  end


end
