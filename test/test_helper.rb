# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module ActionDispatch
  class IntegrationTest
  end
end

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    fixtures :all
    def find_jobs_with_dependancies(jobs)
      collection = []
      jobs.each do |job|
        if job.dependant.present?
          collection.push(job)
        end
      end
      return collection
    end
    # Add more helper methods to be used by all tests here...
  end
end

##
# We only want the permit method from:
#
# https://gist.github.com/promisedlandt/9800713
#
# Everything else is more complex than it needs to be.
#
class PolicyTest < ActiveSupport::TestCase
  ##
  # See if the user is allowed to perform the action on the record specified.
  #
  def permit(current_user, record, action)
    self.class.to_s.gsub(/Test/, '').constantize.new(current_user, record)
        .public_send("#{action}?")
  end
end
