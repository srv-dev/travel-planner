class SessionController < ApplicationController

  def new
  end

  def create

    # Check if email exists in 'Users' table
    user = User.find_by email: params[:email]

    if user.present? && user.authenticate(params[:password])
      # Successful login
      session[:user_id] = user.id

      redirect_to user_path(user.id)
    else
      # Failed login
      flash[:error] = 'Invalid email or password!'

      redirect_to login_path
    end
  end

def destroy
  session[:user_id] = nil # This logs out the user
  redirect_to login_path
end

end
