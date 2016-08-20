class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logined?

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logined?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def unlogin
    redirect_to todos_url if logined?
  end
end
