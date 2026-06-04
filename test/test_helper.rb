ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module Rails
  module LineFiltering
    if Minitest::VERSION.start_with?("6.")
      def run(*args, **kwargs)
        super
      end

      def run_suite(reporter, options = {})
        options = options.merge(include: Rails::TestUnit::Runner.compose_filter(self, options[:include]))

        super
      end
    else
      def run(reporter, options = {})
        options = options.merge(filter: Rails::TestUnit::Runner.compose_filter(self, options[:filter]))

        super
      end
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
