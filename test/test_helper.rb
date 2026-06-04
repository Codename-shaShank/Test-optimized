ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module Rails
  module LineFiltering
    def run(reporter, options = {}, *args, **kwargs)
      options = (options || {}).dup
      options[:filter] = Rails::TestUnit::Runner.compose_filter(self, options[:filter])

      super(reporter, options, *args, **kwargs)
    end
  end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
