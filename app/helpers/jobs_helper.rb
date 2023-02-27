module JobsHelper
  def sort_jobs_by_dependancies(jobs, jobs_with_dependancies)
    if jobs.empty?
      'empty'
    elsif jobs.count == 1
      jobs[0].name
    elsif jobs_with_dependancies.empty?
      jobs.map(&:name).join ', '
    elsif jobs_with_dependancies.present?
      result = []
      dep_helper(jobs, jobs_with_dependancies, result)
      result.map(&:name).uniq.join ', '
    end
  end

  def dep_helper(jobs, jobs_with_dependancies, result)
    jobs_with_dependancies.each do |job|
      dep = job.dependent
      find_dep = Job.find(dep)
      if find_dep.dependent.blank?
        result.push find_dep
        result.push job
      end
    end
    jobs.each do |non_dependent_job|
      result << non_dependent_job
    end
  end
  #
  # Get's the name of a jobs dependant.
  ##
  def dependent_name(dep)
    return unless dep
    Job.find(dep).name
  end
end
