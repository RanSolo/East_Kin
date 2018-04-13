require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # custom validation tests
  test 'should not save jobs cant depend on themselves.' do
    job = Job.create(name: 'b')
    refute job.update(dependant: job.id)
  end

  test 'no circular dependancies.' do
    job_3 = Job.create(name: 'c')
    job_2 = Job.create(name: 'b', dependant: Job.where(name: 'c')[0].id)
    job_1 = Job.create(name: 'a', dependant: Job.where(name: 'b')[0].id)
    refute job_3.update(dependant: job_1.id)
  end
end
