ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'vcr' # copy API call because API calls are expensive
require 'webmock/minitest' # make pretend API response
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

VCR.configure do |config|
  # make cassette files
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = {
    :record => :new_episodes, # create new episode if nothing match
    :match_requests_on => [:method, :uri, :body] # if it matches existing cassette, replay episode
  }
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV['SLACK_TOKEN'] #anytime it sees this variable, replace with string <SLACK_TOKEN>
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end
