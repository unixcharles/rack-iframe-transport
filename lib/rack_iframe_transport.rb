module Rack
  class IframeTransport
    def initialize(app)
      @app = app
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @status, @headers, @response = @app.call(env)
      @request = Rack::Request.new(env)
      @headers['Content-Type'] = 'text/html' if iframe_transport?
      [@status, @headers, self]
    end

    def each(&block)
      block.call(html_document_left) if iframe_transport?
      @response.each(&block)
      block.call(html_document_right) if iframe_transport?
    end

    def iframe_transport?
      @request.params['X-Requested-With'] == 'IFrame'
    end

    def html_document_left
      "<!DOCTYPE html><html><body><textarea #{metadata}>"
    end

    def html_document_right
      "</textarea></body></html>"
    end

    def metadata
      meta = {}
      meta['data-status'] = @response.status if @response.respond_to? :status
      meta['data-statusText'] = @response.status_message if @response.respond_to? :status_message
      meta['data-type'] = @headers['Content-Type'] if @headers.has_key?('Content-Type')
      meta.map {|key,value| "#{key}='#{value}'" }.join(' ')
    end
  end
end