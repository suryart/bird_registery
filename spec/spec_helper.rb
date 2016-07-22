ENV['RACK_ENV'] = 'test'
ENV['API_ENV'] = 'test'

require_relative '../application'
require 'rspec'
require 'rack/test'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Rack::Test::Methods
end