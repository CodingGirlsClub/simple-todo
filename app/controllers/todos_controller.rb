class TodosController < ApplicationController
  before_action :load_todo, only: [:show, :edit, :update, :destroy]

  def index
    load_todos
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    build_todo
  end

  def create
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private

  def load_todo
    @todo ||= todo_scope.find(params[:id])
  end

  def load_todos
    @todo ||= todo_scope.all
  end

  def build_todo
    @todo ||= todo_scope.new
    @todo.attributes = todo_params
  end

  def todo_scope
    Todo
  end

  def todo_params
    todo_params = params[:todo]
    todo_params ? todo_params.permit(:title, :remark, :is_finished) : {}
  end
end
