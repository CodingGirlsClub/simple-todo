class TodosController < ApplicationController
  # 前置过滤器，要求用户必须登上，否则跳转到登录页，定义在ApplicationController
  before_action :need_login
  # 前置过滤器，根据todo id查找该todo项
  before_action :load_todo, only: [:edit, :update, :destroy]

  # 渲染todo列表页，并且实例化一个新的todo，用于添加表单中的form_for
  def index
    load_todos
    build_todo
  end

  # 显示编辑页，修改todo内容
  def edit
  end

  # 编辑完成后，提交表单更新todo项
  # 更新成功跳转到todo列表页
  # 更新失败重新渲染编辑页
  def update
    build_todo
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_path, notice: "更新成功" }
      else
        format.html { render :edit }
      end
    end
  end

  # 创建todo
  # 成功跳转到todo列表页
  # 失败重新渲染index列表页
  def create
    build_todo
    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "创建成功" }
      else
        format.html { render :index }
      end
    end
  end

  # 删除指定id todo项，成功跳转到todo列表页
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: '删除成功' }
    end
  end

  private

  # 根据url中的id查找对应todo
  def load_todo
    @todo ||= todo_scope.find(params[:id])
  end

  # 查找属于当前用户的所有todo项，并根据完成度、创建时间排序
  def load_todos
    @todos ||= current_user.todos.ordered
  end

  # 创建一个todo实例，根据params[:todo]赋值属性
  def build_todo
    @todo ||= todo_scope.new
    @todo.attributes = todo_params.merge(user_id: current_user.id)
  end

  def todo_scope
    Todo
  end

  # strong parameters 检查
  def todo_params
    todo_params = params[:todo]
    todo_params ? todo_params.permit(:title, :remark, :is_finished) : {}
  end
end
