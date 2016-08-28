class UsersController < ApplicationController
  # 前置过滤器，在执行任何一个action之前执行的方法，即检测用户是否登陆
  before_action :unlogin

  # 显示用户注册页
  def new
    build_user
  end

  # 注册逻辑
  # 注册成功，跳转到登录页登陆
  # 注册失败，重新渲染注册页面
  def create
    build_user
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: "注册成功，请登陆" }
      else
        flash[:error] = "用户信息填写有误"
        format.html { render :new }
      end
    end
  end

  private

  # 创建一个新用户，并将表单(params[:user])传入的参数赋值给该实例变量
  def build_user
    @user ||= User.new
    @user.attributes = user_params
  end

  # strong parameters 检查，关于strong parameters可自行查阅Google
  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:username, :password, :password_confirmation) : {}
  end
end
