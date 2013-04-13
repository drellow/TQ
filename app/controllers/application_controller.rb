class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user?, :admin_user

  def current_user?(user)
    user == current_user
  end

  def admin_user
    redirect_to(root_path) unless current_user && current_user.admin?
  end
  
  def read_item(feeditem)
    self.read = true
    self.save!
    redirect_to "#{self.path}"
  end
end
