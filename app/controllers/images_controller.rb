class ImagesController < ApplicationController
  respond_to :json

  def index
    respond_with Image.all
  end

  def show
    respond_with Image.find(params[:id])
  end

  def create
    respond_with Image.create(params[:image])
  end

  def update
    respond_with Image.update(params[:id], params[:image])
  end

  def destroy
    respond_with Image.destroy(params[:id])
  end
  
end
