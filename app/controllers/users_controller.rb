class UsersController < ApplicationController
  before_filter :require_admin_login
  def index
    if params[:search]
			@users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    end
  end

  def show
    @user = User.find(params[:id])
    @note = UserNote.new(:user_id => @user.id)
  end
end
