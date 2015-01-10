class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :make_admin, :remove_admin]
  before_filter :authorize_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_admin_index_path, notice: "User saved"
    else
      redirect_to new_users_admin_path, alert: "There's an error - please check the required fields"
    end
  end

  def make_admin
    @user.make_admin
    redirect_to users_admin_index_path, notice: "#{@user.name} is now an admin"
  end

  def remove_admin
    @user.remove_admin
    redirect_to users_admin_index_path, notice: "#{@user.name} is no longer an admin"
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
