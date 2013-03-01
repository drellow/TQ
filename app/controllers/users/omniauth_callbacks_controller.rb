class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_by_facebook_auth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in @user
      redirect_to root_path
    else
      flash[:notice] = "Something went wrong. Please try signing in again."
      redirect_to new_user_session_path
    end
  end
end