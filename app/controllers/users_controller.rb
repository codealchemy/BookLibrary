class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :make_admin, :remove_admin]
  before_filter :authorize_admin

  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User saved'
      redirect_to users_admin_index_path
    else
      flash[:alert] = 'There\'s an error - please check the required fields'
      redirect_to new_users_admin_path
    end
  end

  def make_admin
    @user.make_admin
    flash[:notice] = "#{@user.name} is now an admin"
    redirect_to users_admin_index_path
  end

  def remove_admin
    @user.remove_admin
    flash[:notice] = "#{@user.name} is no longer an admin"
    redirect_to users_admin_index_path
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :admin
    )
  end
end
