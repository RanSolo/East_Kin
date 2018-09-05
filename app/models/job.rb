class Job < ApplicationRecord
  validate :can_not_dep_on_self, on: :update
  validate :jobs_cant_have_circular_dependencies, on: :update
  has_one :dependent
  accepts_nested_attributes_for :dependent, allow_destroy: true, limit: 1,
                                          reject_if: :all_blank
  #
  # Validates a job cannot depend on itself
  ##
  def can_not_dep_on_self
    unless id != dependent_id
      errors.add(:dependent, "Jobs can’t depend on themselves")
    end
  end

  #
  # Validates jobs don't have circular dependancies
  ##
  def jobs_cant_have_circular_dependencies
    return unless dependent
    dependent_factory(dependent)
    if dependent_id == dep.id
      return errors.add(:dependent, "No circular dependancies
                                     #{dependent_id} #{dep.id} self.dependent =
                                     #{self.dependent} self.id=#{self.id}")
    end
  end

  #
  # Follows a chain of dependencies to it's end and creates a reference array
  ##
  def dependent_factory(dependent)
    return unless dependent.job_id
    dep = dependent.job_id
    dependent_factory(dep)
  end
end
