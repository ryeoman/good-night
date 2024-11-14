ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

begin
  require "simplecov"
  SimpleCov.start "rails" do
    add_filter "/test/"
  end
rescue LoadError
  puts "SimpleCov is not available. Proceeding without coverage metrics."
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
