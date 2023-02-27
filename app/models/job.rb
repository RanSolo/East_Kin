class Job < ApplicationRecord
  validate :can_not_dep_on_self, on: :update
  validate :jobs_cant_have_circular_dependencies, on: :update

  #
  # Validates a job cannot depend on itself
  ##
  def can_not_dep_on_self
    unless id != dependent
      errors.add(:dependent, "Jobs can’t depend on themselves")
    end
  end

  #
  # Validates jobs don't have circular dependancies
  ##
  def jobs_cant_have_circular_dependencies
    return unless dependent
    coll = [] << [id, dependent]
    dependent_factory(coll)
    if coll[0][0] == coll.last[0]
      return errors.add(:dependent, "No circular dependancies
                                     #{coll} #{coll[0][0]} self.dependent =
                                     #{self.dependent} self.id=#{self.id}")
    end
  end

  #
  # Follows a chain of dependancies to it's end and creates a reference array
  ##
  def dependent_factory(coll)
    dep_id = coll.last[1]
    return unless dep_id
    dep = Job.find(dep_id)
    coll << [dep_id, dep.dependent]
    dependent_factory(coll)
  end
end
