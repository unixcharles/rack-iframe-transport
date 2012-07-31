rack-iframe-transport
=====================

Rack middleware for iframe-transport hacks.

Get Rails to work nicely with [jquery-iframe-transport](https://github.com/cmlenz/jquery-iframe-transport/).
Post data to an iframe and retrive data from there is still the only reliable way to post file in a javascript application.

This middleware get Rails to work nicely with [jquery-iframe-transport](https://github.com/cmlenz/jquery-iframe-transport/) or other code of yours that exploit this hack.

What it does?
-------------

It wrap the response in a html. The original response is insert inside a `<textarea>` tag.

Since you can't get headers from an iframe post, metadata are exposed as `'data-*'` attributes of the textarea tag.

```
> curl localhost:3000/api/2/account
  {"message":"Unauthorized"}

> curl 'localhost:3000/api/2/account?X-Requested-With=IFrame'
  <!DOCTYPE html><html><body><textarea 'data-status'='401' 'data-statusText'='Unauthorized' 'data-type'='text/html'>{"message":"Unauthorized"}</textarea></body></html>
```

How?
----

Something like this, its just a Rack middleware.

```ruby
# config/initializer/iframe_transport.rb
require 'rack_iframe_transport'
Teambox::Application.config.middleware.use Rack::IframeTransport
```

Pull request?
-------------

Yes.
