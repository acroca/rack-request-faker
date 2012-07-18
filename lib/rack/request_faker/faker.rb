require 'json'

module Rack
  module RequestFaker
    class Faker
      def initialize(app)
        @app = app
      end

      def call(env)
        if env["HTTP_FAKED_REQUEST"]
          fake = JSON.parse(env["HTTP_FAKED_REQUEST"])
          fake["rack.input"] = StringIO.new(fake["rack.input"]) if fake["rack.input"]
          @app.call(env.merge(fake))
        else
          @app.call(env)
        end
      end
    end
  end
end