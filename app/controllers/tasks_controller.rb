class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_task, except: [:index]

  def index

  end
  
  def show

  end

  def new
    @task = Task.new
  end

  def create
    # @project = Project.find(params[:project_id])
    @task = Task.create(task_params)
    # @task.project << @project

    if @task.save
      # @project.tasks.find_or_create_by(project: @project, role: 10)
      flash[:notice] = 'Task was successfully added.'

      redirect_to projects_path
    end    
  end


  def destroy
      @task = Task.find(params[:id])
      @task.destroy
      flash[:notice] = "Successfully destroyed task."
      @tasks = Task.all
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @project = ProjectUser.find_by(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :difficulty_level, :project_id)
    end
  
end
