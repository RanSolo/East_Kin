class Job < ApplicationRecord
  validate :can_not_dep_on_self, on: :update


  def can_not_dep_on_self
    unless id != dependant
      errors.add(:dependant, "Jobs can’t depend on themselves")
    end
  end

  def jobs_cant_have_circular_dependencies
    return if dependant.nil?
    job = Job.find(id)
    coll = [] << [id, dependant]
    job = Job.find(id)
    dependant_factory(coll)
    if coll[0][0] == coll.last[0]
      return errors.add(:dependant, "No circular dependancies
                                     #{coll} #{coll[0][0]} self.dependant =
                                     #{self.dependant} self.id=#{self.id}")
    end

  end

  def dependant_factory(coll)
    return if coll.last[1].nil?
    dep = Job.find(coll.last[1])

    coll << [dep.id, dep.dependant]

    dependant_factory(coll)
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
