class UsersController < ApplicationController
  before_filter 

  def index
    if current_user.admin?
      @users = User.all
    else
      @users = nil
    end
  end

end
