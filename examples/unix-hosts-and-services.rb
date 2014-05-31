#!/usr/bin/env ruby
# improved unix example with ideas from https://github.com/jedi4ever/livestatus

# for testing local stuff from examples directory
$LOAD_PATH.unshift '../lib'

require 'livestatus'
require 'yaml'

connection = Livestatus::Connection.new({:uri => "unix:///var/nagios/rw/live"})

connection.command("DISABLE_NOTIFICATIONS")

tables = [Livestatus::Host, Livestatus::Service]

tables.each do |table|
  puts "### table #{table.to_s} ###"
  rows = connection.get(table)
  puts rows.to_yaml
end

