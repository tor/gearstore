class UserNotesController < ApplicationController
  before_filter :require_admin_login
  def create
    unote = UserNote.create(params[:user_note])   
    redirect_to user_path(unote.user_id)
  end
end
