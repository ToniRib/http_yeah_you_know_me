require 'socket'
require_relative 'app'
require 'pry'

class ClientHandler
  attr_reader :server, :client

  def initialize(port = 9292)
    @server = TCPServer.open(port)
  end

  def get_request
    @client = server.accept

    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    if request_lines.join.include?('Content-Type')
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      request_lines << client.gets
    end

    request_lines
  end

  def post_response(headers, response)
    # binding.pry
    client.puts headers
    client.puts response
    client.close
  end
end
