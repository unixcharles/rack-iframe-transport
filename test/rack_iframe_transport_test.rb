require_relative 'test_helper'
require File.expand_path('../../lib/rack_iframe_transport', __FILE__)

class RackIframeTransportTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    @target_app = Rack::TestApp.new
    Rack::IframeTransport.new(@target_app)
  end

  def test_with_iframe_param
    get '/', 'X-Requested-With' => 'IFrame'
    expected_response = "<!DOCTYPE html><html><body><textarea data-type='text/html'>foo</textarea></body></html>"
    assert_equal expected_response, last_response.body
  end

  def test_without_iframe_param
    get '/'
    assert_equal "foo", last_response.body
  end
end