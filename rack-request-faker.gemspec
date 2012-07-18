# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rack/request_faker/version'

Gem::Specification.new do |s|
  s.name        = "rack-request-faker"
  s.version     = Rack::RequestFaker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Albert Callarisa Roca"]
  s.email       = ["albert@acroca.com"]
  s.homepage    = "http://github.com/acroca/rack-request-faker"
  s.summary     = "Rack middlewares to log and fake Rack requests"
  s.description = "Rack::RequestFaker contains a couple of middlewares to log and fake Rack requests"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rack-request-faker"

  s.add_development_dependency "bundler",    "~> 1.0"
  s.add_development_dependency "shoulda",    "~> 2.11.3"
  s.add_development_dependency "rack",       "~> 1.2.0"
  s.add_development_dependency "rack-test",  "~> 0.5.4"
  s.add_development_dependency "rspec",  "~> 2.3"

  s.files        = Dir.glob("{lib}/**/*") + %w[README.md]
  s.require_path = 'lib'
end