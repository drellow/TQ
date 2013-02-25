class UsersController < ApplicationController
  # before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  # before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])

    if user.save
      user.refresh_token
      cookies[:session_token] = user.session_token
      redirect_to root_url
    else
      redirect_to new_user_path
    end
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def show
  end


  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
