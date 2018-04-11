module JobsHelper
  def sort_jobs_by_dependancies(jobs)
    if jobs.empty?
      'empty'
    elsif jobs.count == 1
      jobs[0].name
    else
      jobs.map(&:name).join ', '
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
