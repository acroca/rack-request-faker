require 'json'
module Rack
  module RequestFaker
    class Logger
      def initialize(app)
        @app = app
      end

      def call(env)
        log_request(env)
        @app.call(env)
      end

      private

      def log_request(env)
        to_cache = env.to_a.select { |(a, b)| b.is_a?(String) || b.is_a?(TrueClass) || b.is_a?(FalseClass) }
        to_cache = to_cache.inject({ }) { |acc, (a, b)| acc[a]=b; acc }

        to_cache['rack.input'] = env["rack.input"].read
        to_cache['rack.version'] = env["rack.version"]

        REDIS.lpush("logged_requests", to_cache.to_json)
      end
    end
  end
end