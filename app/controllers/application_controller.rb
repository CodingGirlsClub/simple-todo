class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 设置current_user、logined? 方法可以在view中被调用
  helper_method :current_user, :logined?

  # 以user身份登陆，并设置session会话
  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  # 判断当前用户是否登陆
  def logined?
    !!current_user
  end

  # 获取当前用户信息
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # 销毁session会话，设置@current_user为nil，登出
  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  # 如果用户登陆则跳转到todo列表页
  # 防止已登陆用户重复登陆
  def unlogin
    redirect_to todos_url if logined?
  end

  # 如果没有登陆，则跳转到登陆页
  def need_login
    redirect_to login_path unless logined?
  end
end
