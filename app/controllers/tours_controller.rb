class ToursController < ActivePlayerController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]
  before_action :parse_dates, only: [:update, :create]

  # GET /tours
  # GET /tours.json
  def index
    @tours = @active_player.tours
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    @leaders = Table.new(@tour, 'unique_spoils').leaders
    @unclaimed_plates = Plate.all - @tour.spoils.map(&:plate)
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new(tour_params)
    @tour.player = @active_player

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    respond_to do |format|
      puts params
      if @tour.update(tour_params)
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:name, :start_on, :end_on)
    end

    def parse_dates
      params[:start_on] = Chronic.parse(params[:start_on])
      params[:end_on] = Chronic.parse(params[:end_on])
    end
end
