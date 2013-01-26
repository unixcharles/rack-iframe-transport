module Rack
  class IframeTransport
    def initialize(app, tag = 'textarea')
      @app = app
      @tag = tag
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @status, @headers, @response = @app.call(env)
      @request = Rack::Request.new(env)

      if iframe_transport?
        @headers['Content-Type'] = 'text/html'
        [@status, @headers, self]
      else
        [@status, @headers, @response]
      end
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
      "<!DOCTYPE html><html><body><#{@tag} #{metadata}>"
    end

    def html_document_right
      "</#{@tag}></body></html>"
    end

    def metadata
      meta = {}
      meta['data-status'] = @response.status if @response.respond_to? :status
      meta['data-statusText'] = @response.status_message if @response.respond_to? :status_message
      meta['data-type'] = @headers['Content-Type'] if @headers.has_key?('Content-Type')
      meta.map {|key,value| "#{key}='#{value}'" }.join(' ')
    end

    private

    def method_missing(method, *args)
      @response.send(method.intern, *args)
    end
  end
end
