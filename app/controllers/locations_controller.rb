class LocationsController < ApplicationController

  def index
    @locations = Location.all.page(params[:page]).per(15)
  end

  def show
    @location = Location.find(params[:id])
    @users = @location.users.page(params[:user_page]).per(10)
    @books = @location.books.page(params[:book_page]).per(10)
  end
end
