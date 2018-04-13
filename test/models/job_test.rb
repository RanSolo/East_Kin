require 'test_helper'

class JobTest < ActiveSupport::TestCase
  setup do
    @job_1 = Job.create(name: 'a')
    @job_2 = Job.create(name: 'b')
    @job_3 = Job.create(name: 'c')
  end

  # custom validation tests
  test 'should not save jobs cant depend on themselves.' do
    refute @job_1.update(dependant: @job_1.id)
  end

  test 'no circular dependancies.' do
    @job_1.update(dependant: Job.where(name: 'b')[0].id)
    @job_2.update(dependant: Job.where(name: 'c')[0].id)
    refute @job_3.update(dependant: @job_1.id)
  end
end
