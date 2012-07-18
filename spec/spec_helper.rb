ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'

require "rack/test"
require "rspec"

require 'rack_request_faker'


RSpec.configure do |conf|
  conf.include Rack::Test::Methods

end
