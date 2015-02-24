class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # before_action :require_permission, only: [:edit, :destroy]
  
  # GET /projects
  # GET /projects.json
  def index
    @user = current_user
    @projects = Project.page(params[:page]).per(10)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tasks = Task.all
    @project = Project.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
    # @project.owners << current_user
  end

  # GET /projects/1/edit
  def edit
    @project = current_user.projects.find_by(params[:id])

    unless @project.owned_by?
      redirect_to project_path
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      current_user.project_users.find_or_create_by(project: @project, role: 10)
      flash[:notice] = 'Project was successfully added.'

      redirect_to @project
    end

    # respond_to do |format|
    #   if @project.save
    #     format.html { redirect_to @project, notice: 'Project was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @project }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @project.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def require_permission
    if current_user.ROLE != Project.find(params[:id]).ROLE
      redirect_to root_path
      #Or do something else here
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = ProjectUser.find_by(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
