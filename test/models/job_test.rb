require 'test_helper'

class JobTest < ActiveSupport::TestCase
  setup do
    @job_1 = Job.create(name: 'a')
    @job_2 = Job.create(name: 'b')
    @job_3 = Job.create(name: 'c')
  end

  # custom validation tests
  test 'should not save jobs cant depend on themselves.' do
    refute @job_1.update(dependent: @job_1.id)
  end

  test 'no circular dependancies.' do
    @job_1.update(dependent: @job_2.id)
    @job_2.update(dependent: @job_3.id)
    refute @job_3.update(dependent: @job_1.id)
  end
end
