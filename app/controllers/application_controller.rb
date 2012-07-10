class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def require_admin_login
		if session[:user_id] 
	    @current_user = User.find(session[:user_id].to_i)
	    if not @current_user or not @current_user.admin?
	      redirect_to logout_path
	    end
		else
      redirect_to logout_path
		end
  end
end
