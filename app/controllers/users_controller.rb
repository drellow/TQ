class UsersController < ApplicationController
  # before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  # before_filter :correct_user, only: [:edit, :update, :reset_password]
  before_filter :admin_user, only: [:destroy]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    current_user.update_attributes(params)
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def scoreboard
  end

  def show
  end

  def reset_password
    current_user.send_reset_password_instructions
    redirect_to root_path
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
