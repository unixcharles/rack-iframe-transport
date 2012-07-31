ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

module Rack
  class TestApp
    def initialize(app = nil)
      @app = app
    end

    def call(env)
      [200, {}, ["foo"]]
    end
  end
end