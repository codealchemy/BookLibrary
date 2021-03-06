ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'nationbuilder'
require 'factory_bot'
require 'pry'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = Rails.root.join("/spec/fixtures")
  config.include Devise::Test::IntegrationHelpers
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.before(:each) do
    stub_request(:get, /ecs.amazonaws.com/)
    .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
    .to_return(status: 200, body: "stubbed response", headers: {})
  end
end
