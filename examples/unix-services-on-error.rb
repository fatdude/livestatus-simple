#!/usr/bin/env ruby

# for testing local stuff from examples directory
# $LOAD_PATH.unshift '../lib'

require 'livestatus'
require 'pp'

connection = Livestatus::Connection.new({:uri => "unix:///var/nagios/rw/live"})

connection.command("DISABLE_NOTIFICATIONS")

options  = { 
  :columns => 'host_display_name display_name',
  :filter  => ['state > 0', 'description ~ Interface'] 
}

services = connection.get(Livestatus::Service, options)
services.each do |service|
  puts service.data.to_yaml
end

