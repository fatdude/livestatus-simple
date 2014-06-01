livestatus
==========

Livestatus is a simple Ruby library to control Nagios via MK Livestatus.

Homepage: https://github.com/swobspace/livestatus

Installation
------------

```ruby
gem 'livestatus', git: https://github.com/swobspace/livestatus.git, branch: "master"
```

Usage
-----
TBD

See [examples](./examples) for using livestatus.


Testing
-------

Livestatus comes with some tests. You need a running check_mk 
livestatus instance on your local computer. For a quick setup 
I recommend OMD from [omdistro.org](http://www.omdistro.org). 
Install the current omd package, create a site and you get livestatus
running out of the box.

The tests are using environment variables, have a look at ```spec/.env``` for 
configuration. Your mileage may vary, so you can create ```spec/.localenv``` for
overwriting variables in ```spec/.env```. Variables set in the environment
before starting rspec overwrites values in ```spec/.localenv``` and ```spec/.env```.


Contributing to livestatus
--------------------------

- Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet

- Check out the issue tracker to make sure someone already hasn't requested it
  and/or contributed it

- Fork the project

- Start a feature/bugfix branch

- write test for your changes

- Commit and push until you are happy with your contribution

Copyright
---------

Copyright (c) 2014 Wolfgang Barth.
Copyright (c) 2011 Benedikt Böhm. 
See LICENSE for further details.
