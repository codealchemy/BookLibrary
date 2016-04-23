class LocationsController < ApplicationController

  def index
    @locations = Location.all.page(params[:page]).per(15)
  end

  def show
    find_location
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def find_location
    @location = Location.find(params[:id])
    @users = @location.users.page(params[:page]).per(10)
    @books = @location.books
  end
end
