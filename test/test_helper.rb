ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

if Gem::Version.new(Minitest::VERSION) >= Gem::Version.new("6")
  module Minitest6LineFilteringBackport
    def run(klass, method_name, reporter)
      Minitest::Runnable.run(klass, method_name, reporter)
    end

    def run_suite(reporter, options = {})
      options = options.merge(include: Rails::TestUnit::Runner.compose_filter(self, options[:include]))

      super
    end
  end

  ActiveSupport::TestCase.singleton_class.prepend(Minitest6LineFilteringBackport)
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
