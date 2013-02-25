class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_username(params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      user.refresh_token
      cookies.permanent[:session_token] = user.session_token
      redirect_to root_url
    else
      render 'new'
    end
  end


  def destroy
    cookies.delete(:session_token)
    redirect_to root_url
  end

end
