class SessionsController < ApplicationController
  before_action :unlogin, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      login_as user
      flash[:notice] = "登陆成功"
      redirect_to todos_path
    else
      flash[:error] = "用户名或密码错误"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
