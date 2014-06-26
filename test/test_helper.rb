ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

module Rack
  class TestApp
    def initialize(app = nil)
      @app = app
    end

    def call(env)
      if env["PATH_INFO"] == "/json"
        [200, {'Content-Type' => 'application/json'}, ['{"foo":"bar"}']]
      else
        [200, {}, ["foo"]]
      end
    end
  end
end