require "active_support"
require "active_support/core_ext"

require "livestatus-simple/version"
require "livestatus-simple/connection"
require "livestatus-simple/models"
require "livestatus-simple/operators"

module LivestatusSimple
  mattr_accessor :connection
  self.connection = nil

  def self.get(model, options = {})
    connection = self.connection
    connection = connection.call if connection.is_a?(Proc)
    raise RuntimeError, "no global connection found" unless connection
    connection.get(model, options)
  end

  def self.command(cmd, time = nil)
    connection = self.connection
    connection = connection.call if connection.is_a?(Proc)
    raise RuntimeError, "no global connection found" unless connection
    connection.command(cmd, time)
  end
end
