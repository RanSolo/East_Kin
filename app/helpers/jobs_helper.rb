# Helpers related to job code challenge
module JobsHelper

  #
  # Case statement handling printing of jobs with jobs_with_dependancie
  ##
  def sort_jobs_by_dependancies(jobs, jobs_with_dependancies)
    case
    when jobs.empty? # no comma
      'empty'
    when jobs.count == 1 # no comma as there is only one job present
      jobs[0].name
    when jobs_with_dependancies.empty? # map jobs with a ' ,' between
      jobs.map(&:name).join ', '
    when jobs_with_dependancies.present? # ' ,' and calls dep_helper
      dep_helper(jobs, jobs_with_dependancies, result = [])
      result.map(&:name).uniq.join ', '
    end
  end

  #
  # Places jobs in an order so that it is easy to tell what jobs should be
  # done first returning an array of arrays
  ##
  def dep_helper(jobs, jobs_with_dependancies, result)
    # goes through each job with a dependancy from those provided
    jobs_with_dependancies.each do |job|
      # gets that jobs dependent
      find_dep = Job.find(job.dependent)
      if find_dep.dependent.blank?
        result.push find_dep
        result.push job
      end
    end
    # all jobs added to the end of the result array duplicates removed in view
    # with uniqe
    jobs.each do |non_dependent_job|
      result << non_dependent_job
    end
  end

  #
  # Get's the name of a jobs dependent.
  ##
  def dependent_name(dep)
    return unless dep
    Job.find(dep).name
  end
end
