require 'spec_helper'

class FakerTestMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    headers["TESTER_ENV"] = env.to_json
    [status, headers, body]
  end
end


describe Rack::RequestFaker::Faker do
  def app; Rack::Lint.new(@app); end

  def mock_app
    main_app = lambda { |env|
      request = Rack::Request.new(env)
      headers = {'Content-Type' => "text/html"}
      [200, headers, ['Hello world!']]
    }

    builder = Rack::Builder.new
    builder.use Rack::RequestFaker::Faker
    builder.use FakerTestMiddleware
    builder.run main_app
    @app = builder.to_app
  end

  def do_request(fake_request)
    get '/', {}, {"HTTP_FAKED_REQUEST" => fake_request.to_json}
  end

  def response_headers_after_faker
    JSON.parse(last_response.headers["TESTER_ENV"])
  end

  before { mock_app }

  it "overrides the env with the content of the header" do 
    do_request "REQUEST_METHOD" => "POST"
    response_headers_after_faker["REQUEST_METHOD"].should == "POST"
  end
end