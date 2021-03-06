# frozen_string_literal: true

require 'test_helper'

##
# Test for helper methods for Jobs
#
class JobsHelperTest < ActionView::TestCase
  setup do
    @jobs = Job.all
  end

  test 'should return empty with no entries in the database' do
    jobs = []
    assert_match '', sort_jobs_by_dependancies(jobs, [])
  end

  test 'The result should be a sequence consisting of a single job a' do
    assert_match 'a', sort_jobs_by_dependancies(@jobs, [])
  end

  test 'result should be a sequence containing all three jobs abc in no
        significant order' do
      Job.create(name: 'b')
      Job.create(name: 'c')
      @jobs = Job.all #adding more jobs to the total now
      assert_match 'a, b, c', sort_jobs_by_dependancies(@jobs, [])
  end

  test 'result should be a sequence that positions c before b, containing all
        three jobs abc. c depends on b' do
    Job.create(name: 'c')
    Job.create(name: 'b', dependent: Job.where(name: 'c')[0].id)
    @jobs = Job.all
    jobs_with_dependancies = find_jobs_with_dependancies(@jobs)
    assert_match 'c, b, a', sort_jobs_by_dependancies(@jobs, jobs_with_dependancies)
  end

  test 'result should be a sequence that positions
        f before c, c before b, b before e and a before d, containing all six
        jobs abcdef' do
    Job.create(name: 'a')
    Job.create(name: 'f')
    Job.create(name: 'c', dependent: Job.where(name: 'f')[0].id)
    Job.create(name: 'b', dependent: Job.where(name: 'c')[0].id)
    Job.create(name: 'd', dependent: Job.where(name: 'a')[0].id)
    Job.create(name: 'e', dependent: Job.where(name: 'b')[0].id)
    @jobs = Job.all
    jobs_with_dependancies = find_jobs_with_dependancies(@jobs)
    assert_match 'f, c, a, d, b, e', sort_jobs_by_dependancies(@jobs, jobs_with_dependancies)
  end
end
