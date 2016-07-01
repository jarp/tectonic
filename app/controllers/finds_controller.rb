class FindsController < ApplicationController
  before_action :set_find, only: [:show, :edit, :update, :destroy]

  # GET /finds
  # GET /finds.json
  def index
    @finds = Find.all
  end

  # GET /finds/1
  # GET /finds/1.json
  def show
  end

  # GET /finds/new
  def new
    @find = Find.new
  end

  # GET /finds/1/edit
  def edit
  end

  # POST /finds
  # POST /finds.json
  def create
    puts params
    @find = Find.new()
    @find.game_id = cookies["current_game_id"]
    @find.player_id = session[:player_id]
    puts "%%%%%%%%%%%%%%%%"
    puts Plate.find_by_code(params[:code]).inspect
    @find.plate_id = Plate.find_by_code(params[:code]).id

    respond_to do |format|
      if @find.save
        format.html { redirect_to @find, notice: 'Find was successfully created.' }
        format.json { render :show, status: :created, location: @find }
      else
        format.html { render :new }
        format.json { render json: @find.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /finds/1
  # PATCH/PUT /finds/1.json
  def update
    respond_to do |format|
      if @find.update(find_params)
        format.html { redirect_to @find, notice: 'Find was successfully updated.' }
        format.json { render :show, status: :ok, location: @find }
      else
        format.html { render :edit }
        format.json { render json: @find.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finds/1
  # DELETE /finds/1.json
  def destroy
    @find.destroy
    respond_to do |format|
      format.html { redirect_to finds_url, notice: 'Find was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_find
      @find = Find.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def find_params
      params.require(:find).permit(:plate_id)
    end
end
