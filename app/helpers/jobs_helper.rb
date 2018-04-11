module JobsHelper
  def sort_jobs_by_dependancies(jobs)
    if jobs.empty?
      'empty'
    end
  end

  def status(job)
    if job.status == true
      'X'
    else
      'O'
    end
  end
end
