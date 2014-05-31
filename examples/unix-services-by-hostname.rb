#!/usr/bin/env ruby

# for testing local stuff from examples directory
$LOAD_PATH.unshift '../lib'

require 'livestatus'
require 'yaml'

connection = Livestatus::Connection.new({:uri => "unix:///var/nagios/rw/live"})

connection.command("DISABLE_NOTIFICATIONS")

options  = { 
  :columns => 'host_name description state_type acknowledged',
  :filter  => ['state > 0', 'state_type = 1', 
               'acknowledged = 0', 'host_name = wobgate'] 
}

services = connection.get(Livestatus::Service, options)
services.each do |service|
  puts service.data.to_yaml
end

