class Job < ApplicationRecord
  validate :can_not_dep_on_self, on: :update
  validate :jobs_cant_have_circular_dependencies, on: :update

  #
  # Validates a job cannot depend on itself
  ##
  def can_not_dep_on_self
    unless id != dependant
      errors.add(:dependant, "Jobs can’t depend on themselves")
    end
  end

  #
  # Validates jobs don't have circular dependancies
  ##
  def jobs_cant_have_circular_dependencies
    return unless dependant
    coll = [] << [id, dependant]
    dependant_factory(coll)
    if coll[0][0] == coll.last[0]
      return errors.add(:dependant, "No circular dependancies
                                     #{coll} #{coll[0][0]} self.dependant =
                                     #{self.dependant} self.id=#{self.id}")
    end
  end

  #
  # Follows a chain of dependancies to it's end and creates a reference array
  ##
  def dependant_factory(coll)
    dep_id = coll.last[1]
    return unless dep_id
    dep = Job.find(dep_id)
    coll << [dep_id, dep.dependant]
    dependant_factory(coll)
  end
end
