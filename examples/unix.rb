#!/usr/bin/env ruby

# for testing local stuff from examples directory
$LOAD_PATH.unshift '../lib'

require 'livestatus'
require 'yaml'

c = Livestatus::Connection.new({:uri => "unix:///var/nagios/rw/live"})

c.command("DISABLE_NOTIFICATIONS")
puts c.get(Livestatus::Status)[0].data.to_yaml
