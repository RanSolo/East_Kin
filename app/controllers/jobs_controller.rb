class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_jobs, only: [:index, :show, :new, :edit, :update, :destroy]
  layout "jobs"
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
    @jobs_with_dependancies = find_jobs_with_dependancies(@jobs)
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show; end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit; end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @jobs = Job.all
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html do
        redirect_to jobs_url, notice: 'Job was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def find_jobs_with_dependancies(jobs)
    collection = []
    jobs.each do |job|
      if job.dependant.present?
        collection.push(job)
      end
    end
    return collection
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  def set_jobs
    @jobs = Job.all
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def job_params
    params.require(:job).permit(:status, :dependant, :name, :label)
  end
end
