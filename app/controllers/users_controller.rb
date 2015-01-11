class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :edit, :make_admin, :remove_admin, :destroy, :update]
  before_filter :authorize_admin, only: [:edit, :create, :new, :index, :update]

  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def new
    @user = User.new
  end

  def update
    @user.update_attributes(update_user_params)
    if @user.save
      flash[:notice] = 'User saved'
      redirect_to users_admin_path(@user)
    else
      flash[:alert] = 'There\'s an error - please check the required fields'
      redirect_to users_admin_path(@user)
    end
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

  def destroy
    @user.destroy
    flash[:notice] = 'User has been deleted'
    redirect_to users_admin_index_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :admin)
  end

  def update_user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email).permit!
  end
end
