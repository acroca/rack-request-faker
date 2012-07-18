require 'spec_helper'


describe Rack::RequestFaker::Logger do


  def app; Rack::Lint.new(@app); end

  def mock_app
    main_app = lambda { |env|
      request = Rack::Request.new(env)
      headers = {'Content-Type' => "text/html"}
      [200, headers, ['Hello world!']]
    }

    builder = Rack::Builder.new
    builder.use Rack::RequestFaker::Logger
    builder.use FakerTestMiddleware
    builder.run main_app
    @app = builder.to_app
  end

  before do
    mock_app
    REDIS ||= double
  end

  it "logs the path" do 
    REDIS.should_receive("lpush").with("logged_requests", match(/this_is_the_path/))
    get "/this_is_the_path"
  end

  it "logs the params" do 
    REDIS.should_receive("lpush").with("logged_requests", match(/param1=value1/))
    get "/", {param1: "value1"}
  end

  it "logs the headers" do 
    REDIS.should_receive("lpush").with("logged_requests", match(/"HTTP_HEADER_1":"value1"/))
    get "/", {}, {"HTTP_HEADER_1" => "value1"}
  end

  it "logs in a json format" do
    REDIS.should_receive("lpush").with do |_, json|
      JSON.parse(json)
    end
    expect { get('/') }.to_not raise_error
  end
end