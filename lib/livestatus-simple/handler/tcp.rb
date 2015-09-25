require 'livestatus-simple/handler'
require 'uri'
require 'yajl'

module LivestatusSimple

  class TCPHandler
    def initialize(connection, config)
      @connection = connection
      @uri = URI(config[:uri])
    end

    def get(model, options = {})
      options.merge!({
        response_header: "fixed16",
        output_format: "json",
        column_headers: 'on'
      })

      send("GET #{model.table_name}\n#{build_headers(options)}\n")
      status, length = recv

      unless status == 200
        raise HandlerException, "livestatus query failed with status #{status}"
      end

      data = Yajl::Parser.parse(recv(length))

      column_zip(data, options).map do |d|
        model.new(d, @connection)
      end
    end

    def command(cmd, time = nil)
      time = Time.now.to_i unless time
      send("COMMAND [#{time}] #{cmd}\n")
      nil
    end

    private

    def socket
      @socket ||= socket!
      @socket = socket! if @socket.closed?
      @socket
    end

    def socket!
      TCPSocket.open(@uri.host, @uri.port)
    end

    def send(msg)
      socket.write(msg + "\n")
    end

    def recv(length = nil)
      if length.nil?
        # read response header
        res = socket.read(16)
        [res[0..2].to_i, res[4..14].chomp.to_i]
      else
        # read response body
        data = socket.read(length)
        socket.close
        data
      end
    end

    def build_headers(options)
      options.map do |k, v|
        if k == :raw
          v
        else
          if v.is_a?(Array)
            v.map do |e|
              "#{k.to_s.camelize}: #{e}"
            end
          else
            "#{k.to_s.camelize}: #{v}"
          end
        end
      end.flatten.join("\n")
    end

    def column_zip(data, options)
      if options.include?(:columns)
        columns = options[:columns].split(" ")
      else
        columns = data.delete_at(0)
      end

      data.map do |d|
        Hash[columns.zip(d)]
      end
    end
  end

end