class ScenariosController < ApplicationController
  #authorization
  include Pundit

  before_action :find_project
  before_action :set_scenario, only: [:show, :edit, :update, :destroy, :run]
  before_action :init_result, only: [:run, :go]
  # Pundit check current_user
  before_action :authorize?, only: [:new, :edit, :update, :create, :destroy]
  # Pundit rescue not_authorized
  rescue_from Pundit::NotAuthorizedError, with: :current_user_not_authorized

  # GET /scenarios
  # GET /scenarios.json
  def index
    @scenarios = @project.scenarios.order(updated_at: :desc, created_at: :desc).page(params[:page]).per(10)
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
  end

  # GET /scenarios/new
  def new
    @scenario = Scenario.new(project: @project)
  end

  # GET /scenarios/1/edit
  def edit
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = Scenario.new(scenario_params)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to project_scenarios_path, notice: 'Scenario was successfully created.' }
        format.json { render :show, status: :created, location: project_scenarios_path }
      else
        format.html { render :new }
        format.json { render json: project_scenarios_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenarios/1
  # PATCH/PUT /scenarios/1.json
  def update
    create if @scenario.id == nil
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to project_scenarios_path, notice: 'Scenario was successfully updated.' }
        format.json { render :show, status: :ok, location: project_scenarios_path }
      else
        format.html { render :edit }
        format.json { render json: project_scenarios_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to project_scenarios_path, notice: 'Scenario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def run
    # @scenario.run_case!
    @results << Scenario.new.run_case(@scenario)
    flash[:notice] = 'Scenario was successfully ran'
  end

  def go
    # @project.run_project
    @results = Project.new.run_project(@project)
    flash[:notice] = 'All scenarios were successfully ran'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scenario
      @scenario = Scenario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scenario_params
      params.require(:scenario).permit(:project_id, :title, :url, :headers, :method, :body, :cookies, :active, :status, :expected_status, :expected_body, :schedule, :description)
    end

    def find_project
      @project = Project.find(params[:project_id])
    end

    def init_result
      @results = []
    end

    def authorize?
      authorize current_user
    end

    def current_user_not_authorized
      flash[:alert] = "You are not authorized to perform this action, plz use QA account."
      redirect_to(request.referrer || root_path)
    end
end
