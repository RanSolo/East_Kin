require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # custom validation tests
  test 'should not save jobs cant depend on themselves.' do
    job = Job.create(name: 'b')
    refute job.update(dependant: job.id)
  end

  test 'no circular dependancies.' do
    job_d = Job.new(name: 'd')
    job_c =Job.create(name: 'c', dependant: job_d.id)
    job_b = Job.create(name: 'b', dependant: job_c.id)
    job_d.update(dependant: job_b.id)
    refute job_d.save
  end
end
