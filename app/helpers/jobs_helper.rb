module JobsHelper
  def status(job)
    if job.status == true
      'X'
    else
      'O'
    end
  end
end
