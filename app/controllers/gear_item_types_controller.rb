class GearItemTypesController < ApplicationController
  def index
    @gits = GearItemType.all
  end

  def new
    @git = GearItemType.new
  end

  def create
    GearItemType.create! params[:gear_item_type]
    redirect_to gear_item_types_path
  end

  def edit
    @git = GearItemType.find(params[:id])
  end

  def update
    @git = GearItemType.find(params[:id])
    @git.update_attributes(params[:gear_item_type]) 
    redirect_to gear_item_types_path
  end

  def destroy
    git = GearItemType.find(params[:id])
    git.retire
    
    redirect_to gear_item_types_path
  end
end
