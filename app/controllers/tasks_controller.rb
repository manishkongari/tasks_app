# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
  
    # GET /tasks
    def index
      @tasks = Task.all
    #   render json: @tasks
    end
  
    # GET /tasks/1
    def show
      render json: @task
    end
  
    # GET /tasks/new
    def new
      @task = Task.new
    end
  
    # GET /tasks/1/edit
    def edit
    end
  
    # POST /tasks
    def create
      @task = Task.new(task_params)
  
      if @task.save
        redirect_to tasks_path, notice: 'Task was successfully created.'
    else
        render :new
      end
    end
  
    def update
        if @task.update(task_params)
            redirect_to tasks_path, notice: 'Task was successfully updated.'
        else
            render :edit
        end
    end
  
    def destroy
        @task.destroy
        redirect_to tasks_url, notice: 'Task was successfully deleted.'
    end
  
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :status)
    end
  end
  