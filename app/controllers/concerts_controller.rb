class ConcertsController < ApplicationController
  before_action :set_concert, only: %i[ show edit update destroy ]

  # GET /concerts or /concerts.json
  def index
    @group = Group.find(params[:group_id])
    @concerts = @group.concerts
  end

  # GET /concerts/1 or /concerts/1.json
  def show
    @group = Group.find(params[:group_id])
    @concert = Concert.find(params[:id])
  end

  # GET /concerts/new
  def new
    @group = Group.find(params[:group_id])
    @concert = Concert.new
  end

  # GET /concerts/1/edit
  def edit
    @group = Group.find(params[:group_id])
    @concert = Concert.find(params[:id])
  end

  # POST /concerts or /concerts.json
  def create
    @group = Group.find(params[:group_id])
    @concert = Concert.new(concert_params)
    @concert.group = @group

    respond_to do |format|
      if @concert.save
        format.html { redirect_to group_concert_path(@group, @concert), notice: "Concert was successfully created." }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concerts/1 or /concerts/1.json
  def update
    @group = Group.find(params[:group_id])
    @concert = Concert.find(params[:id])
    respond_to do |format|
      if @concert.update(concert_params.merge(group: @group))
        format.html { redirect_to group_concert_path(@group, @concert), notice: "Concert was successfully updated." }
        format.json { render :show, status: :ok, location: @concert }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concerts/1 or /concerts/1.json
  def destroy
    @concert.destroy
    respond_to do |format|
      format.html { redirect_to group_concerts_url, notice: "Concert was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert
      @concert = Concert.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def concert_params
      params.require(:concert).permit(:date, :length, :attendants)
    end
end
