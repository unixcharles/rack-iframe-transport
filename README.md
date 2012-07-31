rack-iframe-transport
=====================

Rack middleware for iframe-transport hacks.

Get Rails to work nicely with [jquery-iframe-transport](https://github.com/cmlenz/jquery-iframe-transport/).

What it does?
-------------

It give [jquery-iframe-transport](https://github.com/cmlenz/jquery-iframe-transport/) the expected response.

```
> curl localhost:3000/api/2/account
  {"message":"Unauthorized"}

> curl 'localhost:3000/api/2/account?X-Requested-With=IFrame'
  <!DOCTYPE html><html><body><textarea 'data-status'='401' 'data-statusText'='Unauthorized' 'data-type'='text/html'>{"message":"Unauthorized"}</textarea></body></html>
```

Pull request?
-------------

Yes.
>>>>>>> Initial commit
