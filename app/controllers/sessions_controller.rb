class SessionsController < ApplicationController
  before_action :unlogin, except: [:destroy]

  # 显示用户登陆表单
  def new
  end

  # 点击登陆，执行该Action
  # 通过 「username」、「password」来查找对应用户，并匹配密码
  # 匹配成功，则登录并跳转todo列表页
  # 匹配失败，则重新渲染new页面(这样会保留上一次输入内容，用户体验效果更佳)
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      # login_as 存在于ApplicationController中的公共方法
      login_as user
      flash[:notice] = "登陆成功"
      redirect_to todos_path
    else
      flash[:error] = "用户名或密码错误"
      render :new
    end
  end

  # 登出用户，并跳转到登陆页
  def destroy
    # logout 定义在ApplicationController中
    logout
    redirect_to login_path
  end
end
