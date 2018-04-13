class Job < ApplicationRecord
  validate :can_not_dep_on_self, on: :update
  validate :jobs_cant_have_circular_dependencies, on: :update

  def can_not_dep_on_self
    unless id != dependant
      errors.add(:dependant, "Jobs can’t depend on themselves")
    end
  end

  def jobs_cant_have_circular_dependencies
    @jwds = find_jobs_with_dependancies(Job.all)
    @coll = []
    @jwds.each do |j|
      collection = []
      unless j.dependant.nil?
        collection << [j.id, j.dependant]
        dj = Job.find(j.dependant)
      end
      unless dj.dependant.nil?
        collection << [dj.id, dj.dependant]
      end
      @coll << collection
      if @coll[0][0] == @coll.last[0]
        return errors.add(:dependant, @coll[0][0] + @coll.last[0])
      end
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
