class WelcomesController < ApplicationController
  before_action :all_welcomes, only: [:index, :create]
  before_action :set_welcome, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json


  # GET /welcomes
  # GET /welcomes.json
 def index
   @welcome = Welcome.find(1)
 end
  # GET /welcomes/1
  # GET /welcomes/1.json
  def show
  end

  # GET /welcomes/new
  def new
    @welcome = Welcome.new
  end

  # GET /welcomes/1/edit
  def edit
  end

  # POST /welcomes
  # POST /welcomes.json
  def create
    @welcome = Welcome.new(welcome_params)

    respond_to do |format|
      if @welcome.save
        format.html { redirect_to @welcome, notice: 'Welcome was successfully created.' }
        format.json { render :show, status: :created, location: @welcome }
      else
        format.html { render :new }
        format.json { render json: @welcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /welcomes/1
  # PATCH/PUT /welcomes/1.json
  def update
    if params['lifeOrDeath'] == 'death'
      @welcome.destroy_count = @welcome.destroy_count + 1
      @welcome.save
    else params['lifeOrDeath'] == 'life'
      @welcome.restart_count = @welcome.restart_count + 1
      @welcome.save
    end
  end

  # DELETE /welcomes/1
  # DELETE /welcomes/1.json
  def destroy
    @welcome.destroy
    respond_to do |format|
      format.html { redirect_to welcomes_url, notice: 'Welcome was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_welcome
    @welcome = Welcome.find(1)
  end

  def all_welcomes
    @welcomes = Welcome.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def welcome_params
    params.require(:welcome).permit(:bandName, :headline, :message, :logo, :destroy_count, :restart_count, :lifeOrDeath)
  end
end
