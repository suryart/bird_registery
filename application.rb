# application.rb
require 'grape'
require 'grape-rabl'
require 'mongoid'

ENV['API_ENV'] ||= 'development'
ENV['API_ROOT'] = Dir.pwd

mongoid_config_path = File.join(ENV['API_ROOT'], 'config', 'mongoid.yml')

Mongoid.load!(mongoid_config_path, ENV['API_ENV'])

# Load files from the models and api folders
$:.unshift File.dirname(__FILE__)

Dir["app/models/**/*.rb"].each { |f| require f }
Dir["app/api/**/*.rb"].each { |f| require f }

# Grape API class. We will inherit from it in our future controllers.
module API
  class Root < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl
    prefix :api
 
    # Simple endpoint to get the current status of our API.
    get :status do
      { status: 'ok' }
    end

    mount V1::Birds

  end
end
 
# Mounting the Grape application
BirdRegistery = Rack::Builder.new {
 
  map "/" do
    run API::Root
  end
 
}