# jobs controller
class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_req_by_form, only: [:index, :show, :new, :edit, :update,
                                         :destroy]
  layout "jobs"
  # GET /jobs
  # GET /jobs.json
  def index
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
        @dep = Dependent.create(name: @job.name)
        @dep.save
        @job.update(dependent_id: @dep.id)
        @job.save
        respond_to_success(format)
      else
        respond_to_failure(format)
      end
    end
  end

  def respond_to_success(format)
    format.html { redirect_to @job, notice: 'Successfully created.' }
    format.json { render :show, status: :created, location: @job }
  end

  def respond_to_failure(format)
    format.html { render :new }
    format.json { render json: @job.errors, status: :unprocessable_entity }
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
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
    @dep = Dependent.find(@job.id)
    @job.destroy
    @dep.destroy
    respond_to do |format|
      format.html do
        redirect_to jobs_url, notice: 'Job was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

# Create array with that separates jobs with dependancies from those without.
  def find_jobs_with_dependancies(jobs)
    collection = []
    jobs.each do |job|
      if job.dependent.present?
        collection.push(job)
      end
    end
    return collection
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  def set_req_by_form
    @jobs = Job.order( 'name ASC' )
    @dependents = Dependent.order( 'name ASC')
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def job_params
    params.require(:job).permit(:status, :dependent_id, :name, :label,
    dependent_attributes: %i[:name :job_id])
  end
end
