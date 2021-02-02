class CrewsController < ApplicationController
  before_action :set_crew, only: %i[ show edit update destroy ]

  # GET /crews or /crews.json
  def index
    @group = Group.find(params[:group_id])
    @crews = @group.crews
  end

  # GET /crews/1 or /crews/1.json
  def show
    @group = Group.find(params[:group_id])
    @crew = Crew.find(params[:id])
  end

  # GET /crews/new
  def new
    @group = Group.find(params[:group_id])
    @crew = Crew.new
  end

  # GET /crews/1/edit
  def edit
    @group = Group.find(params[:group_id])
    @crew = Crew.find(params[:id])
  end

  # POST /crews or /crews.json
  def create
    @group = Group.find(params[:group_id])
    @crew = Crew.new(crew_params)
    @crew.group = @group

    respond_to do |format|
      if @crew.save
        format.html { redirect_to group_crew_path(@group, @crew), notice: "Crew was successfully created." }
        format.json { render :show, status: :created, location: @crew }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crews/1 or /crews/1.json
  def update
    @group = Group.find(params[:group_id])
    @crew = Crew.find(params[:id])
    respond_to do |format|
      if @crew.update(crew_params)
        format.html { redirect_to group_crew_path(@group, @crew), notice: "Crew was successfully updated." }
        format.json { render :show, status: :ok, location: @crew }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crews/1 or /crews/1.json
  def destroy
    @crew.destroy
    respond_to do |format|
      format.html { redirect_to group_crews_url, notice: "Crew was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew
      @crew = Crew.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crew_params
      params.require(:crew).permit(:name)
    end
end
