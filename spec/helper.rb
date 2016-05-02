$LOAD_PATH.unshift File.expand_path('..', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
require 'yellow_api'
require 'rspec'
require 'pry'
require 'vcr'
require 'webmock/rspec'
require 'active_support/all'
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<YELLOW_API_KEY>') { ENV['YELLOW_API_KEY'] }
end

RSpec.configure do |config|
  # Add VCR to all tests
  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      sleep 2
      name = example.metadata[:full_description]
             .split(/\s+/, 2)
             .join('/')
             .underscore
             .tr('.', '/')
             .gsub(%r{[^\w/]+}, '_')
             .gsub(%r{/$}, '')
      VCR.use_cassette(name, options, &example)
    end
  end
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
