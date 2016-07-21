require_relative 'application'

use Rack::Config do |env|
  env['api.tilt.root'] = File.expand_path('../app/views', __FILE__)
end

run BirdRegistery