require 'pry'
class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    prior = {1 => "1 - ASAP", 2 => "2 - Very high", 3 => "3 - High", 4 => "4 - Medium", 5 => "5 - Low" }
    @projects = Project.all
    priority, effect, task = params[:priority], params[:effect], params[:task]
    if priority
      p = priority[0].to_i
      return false if p<1 || p>5
      task = Task.find(task) 
      if effect == "up"
        task.priority = prior[p-1]
      else
        task.priority = prior[p+1]
      end
      task.save
      redirect_to projects_url
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    tasks=Task.all.where(project_id: @project.id)
    @names=""
    tasks.each do |task|
      @names+=task.name+"; "
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
