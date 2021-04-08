# Canvas FIPS Compliance
This Canvas plugin patches some FIPS compliance issues in Canvas.  This plugin only fixes functionality which
is not likely to be fixed upstream in the Canvas repository.  There is a separate Canvas patch which fixes the
majority of FIPS compliance issues in Canvas itself.

## Installation
Clone this repo into the Canvas Plugins directory on your app server:
```sh
sysadmin@appserver:~$ cd /path/to/canvas/gems/plugins
sysadmin@appserver:/path/to/canvas/gems/plugins$ git clone https://github.com/atomicjolt/canvas_fips.git
```

Now `bundle install` and `bundle exec rake canvas:compile_assets` and `rails sefips`.

After it is up, login with the site admin account and head over to the `/plugins` route (Navigated to by clicking `Admin -> Site Admin -> Plugins`).
Once there, scroll down to `Canvas FIPS Compliance` and click into it.  Enable the plugin.

You should be all set now. Enjoy!

## Configuration

Configuration can be placed in `/path/to/canvas/config/fips.yml`:

```sh
production:
  # Set to true to raise exception on Digest::MD5 calls, which should prevent
  # the FIPS extensions from killing rails server. When false, the plugin only logs warnings.
  raise_exceptions: true

development:
  raise_exceptions: true
  
test:
  raise_exceptions: true
```
