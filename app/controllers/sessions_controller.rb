class SessionsController < ApplicationController

  def new
  end

  def create
    u = User.authenticate(params[:user], params[:pass])
    if u
      session[:user_id] = u.id
      redirect_to rentals_path
    else
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
