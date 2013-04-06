class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user?, :admin_user

  def current_user?(user)
    user == current_user
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  def feeditems
    current_user.feeditems
  end

end
