require "active_support/core_ext"

module LivestatusSimple
  mattr_accessor :models
  self.models = {}

  class Base
    attr_reader :data

    def initialize(data, connection = nil)
      @data = data.symbolize_keys!
      @connection = connection
    end

    def method_missing(name, *args, &block)
       data.fetch(name.to_sym)
    end

    class << self
      def table_name(value = nil)
        return @table_name if @table_name

        @table_name = value||to_s.demodulize.downcase.tableize
        @table_name
      end

      def boolean_attributes(*accessors)
        accessors.each do |m|
          define_method(m) do
            data[m] == 1
          end
        end
      end

      def time_attributes(*accessors)
        accessors.each do |m|
          define_method(m) do
            Time.at(data[m].to_i)
          end
        end
      end
    end
  end

  module State
    def state
      {
        0 => :ok,
        1 => :warning,
        2 => :critical,
        3 => :unknown,
      }[data[:state]]
    end

    def state_class
      {
        :ok => :green,
        :warning => :yellow,
        :critical => :red,
        :unknown => :orange,
        :pending => :gray,
      }[state]
    end

    def state_type
      {
        0 => :soft,
        1 => :hard,
      }[data[:state_type]]
    end
  end

  module CheckType
    def check_type
      {
        0 => :active,
        1 => :passive,
      }[data[:check_type]]
    end
  end
end

# load all models and register in LivestatusSimple.models
Dir["#{File.dirname(__FILE__)}/models/*.rb"].map do |path|
  File.basename(path, '.rb')
end.each do |name|
  require "livestatus-simple/models/#{name}"
  model = "LivestatusSimple::#{name.classify}".constantize
  LivestatusSimple.models[model.table_name] = model
end
