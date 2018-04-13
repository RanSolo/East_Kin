class Job < ApplicationRecord
  validate :can_not_dep_on_self, on: :update
  validate :jobs_cant_have_circular_dependencies, on: :update

  def can_not_dep_on_self
    unless id != dependant
      errors.add(:dependant, "Jobs can’t depend on themselves")
    end
  end

  def jobs_cant_have_circular_dependencies
    coll = []
    jwds = find_jobs_with_dependancies(Job.all)
    jwds.each do |j|
      coll << [j.id, j.dependant]
      dependant_factory(j, jwds, coll)
      if coll[0][0] == self.dependant
        return errors.add(:dependant, "No circular dependancies
                                       #{coll} #{self.dependant}")
      end
    end
  end

  def dependant_factory(job, jwds, coll)
    fjwds = find_jobs_with_dependancies(jwds)
    i = 0
    dep = Job.find(job.dependant)
    return if dep.dependant.nil? ||
    dep = Job.find(job.dependant)
    coll << [dep.id, dep.dependant]
    while i < fjwds.count
      i += 1
      dependant_factory(dep, jwds,coll)
    end
  end

  def find_jobs_with_dependancies(jobs)
    collection = []
    jobs.each do |job|
      if job.dependant.present?
        collection.push(job)
      end
    end
    return collection
  end
end
