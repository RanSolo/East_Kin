# frozen_string_literal: true

require 'test_helper'

##
# Test for helper methods for Jobs
#
class JobsHelperTest < ActionView::TestCase

  test 'should return empty' do
      @jobs = []

      assert_match 'empty', sort_jobs_by_dependancies(@jobs)
  end
end
