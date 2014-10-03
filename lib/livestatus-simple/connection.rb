require "livestatus-simple/handler"
require "livestatus-simple/memoize"
require "forwardable"

module LivestatusSimple

  class Connection
    extend Forwardable

    def_delegators :handler, :get, :command

    def initialize(config)
      @config = config.symbolize_keys!
    end

    def handler
      raise ArgumentError, "unknown uri type: #{@config[:uri]}" unless @config[:uri] =~ /^unix:\/\//

      UnixHandler.new(self, @config)
    end

    memoize :handler
  end

end
