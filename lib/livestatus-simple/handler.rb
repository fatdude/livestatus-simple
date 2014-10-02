module LivestatusSimple
  class HandlerException < StandardError; end
end

Dir["#{File.dirname(__FILE__)}/handler/*.rb"].each do |path|
  require "livestatus-simple/handler/#{File.basename(path, '.rb')}"
end
