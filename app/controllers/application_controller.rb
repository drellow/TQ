class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user
  helper_method :logged_in?, :current_user, :current_user?

  def current_user?(user)
    user == @current_user
  end

  def current_user
    @current_user
  end

  def set_current_user
    unless cookies[:session_token].nil?
      @current_user = User.find_by_session_token(cookies[:session_token])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !!current_user
  end


end
