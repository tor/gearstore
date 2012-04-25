class GearItemNotesController < ApplicationController

  before_filter :require_admin_login
	def create 
		gin = GearItemNote.create(params[:gear_item_note])
		redirect_to gear_item_path(gin.gear_item)
	end
end
