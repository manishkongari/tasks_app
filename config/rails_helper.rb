# rails_helper.rb

# Set the Rails environment to 'test' if it's not already set
ENV['RAILS_ENV'] ||= 'test'

# Load the Rails application's environment
require File.expand_path('../../config/environment', __FILE__)

# Load RSpec and integrate it with Rails
require 'rspec/rails'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

# Load the spec_helper.rb file (deprecated but still present in some setups)
require 'spec_helper'

# Maintain the test database schema
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# RSpec configuration block
RSpec.configure do |config|
  # Set the path to fixtures for RSpec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Use transactional fixtures to roll back changes made during each test
  config.use_transactional_fixtures = true

  # Infer the type of spec based on file location
  config.infer_spec_type_from_file_location!

  # Filter out Rails-related backtrace lines for cleaner output
  config.filter_rails_from_backtrace!
end
