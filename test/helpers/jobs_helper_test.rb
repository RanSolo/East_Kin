# frozen_string_literal: true

require 'test_helper'

##
# Test for helper methods for Jobs
#
class JobsHelperTest < ActionView::TestCase
  setup do
    @jobs = Job.all
  end

  test 'should return empty' do
    jobs = []
    assert_match 'empty', sort_jobs_by_dependancies(jobs)
  end

  test 'The result should be a sequence consisting of a single job a' do
      assert_match 'a', sort_jobs_by_dependancies(@jobs)
  end

  test 'result should be a sequence containing all three jobs abc in no
        significant order' do
      job_b = Job.create(name: 'b')
      job_c = Job.create(name: 'c')
      @jobs = Job.all
      assert_match 'a, b, c', sort_jobs_by_dependancies(@jobs)
  end
end
