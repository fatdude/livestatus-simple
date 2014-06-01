#!/usr/bin/env ruby
#
# usage:
# ruby services-with-filter.rb "acknowledged = 0" "state > 0" "host_state = 0" "host_state_type = 1"
#
# for testing local stuff from examples directory
$LOAD_PATH.unshift '../lib'

require 'livestatus'

connection = Livestatus::Connection.new({:uri => "unix:///var/nagios/rw/live"})

options  = { 
  :columns => 'host_name description state state_type acknowledged',
  :filter  => ARGV
}

services = connection.get(Livestatus::Service, options)
services.each do |service|
  puts "#{service.host_name} / #{service.description}"
  puts "  #{service.state} / #{service.state_type} [#{service.state_class}]"
  puts "  acknowledged: #{service.acknowledged}"
end

