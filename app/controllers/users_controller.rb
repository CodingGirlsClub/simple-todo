class UsersController < ApplicationController
  before_action :unlogin

  def new
    build_user
  end

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

  def build_user
    @user ||= User.new
    @user.attributes = user_params
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:username, :password, :password_confirmation) : {}
  end
end
