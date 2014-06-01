#!/usr/bin/env ruby
# improved unix example with ideas from https://github.com/jedi4ever/livestatus

# for testing local stuff from examples directory
$LOAD_PATH.unshift '../lib'

require 'livestatus'
require 'yaml'

connection = Livestatus::Connection.new({:uri => "unix:///var/nagios/rw/live"})

hosts = connection.get(Livestatus::Host)

hosts.each do |host|
  puts "### host #{host.to_s} ###"
  puts host.to_yaml
  puts host.services.to_yaml
end

