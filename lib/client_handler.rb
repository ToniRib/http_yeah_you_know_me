require 'socket'
require_relative 'app'

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

    get_body_info(request_lines) if body_exists(request_lines)

    request_lines
  end

  def body_exists(request_lines)
    request_lines.join.include?('Content-Type')
  end

  def get_body_info(request_lines)
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    request_lines << client.gets
  end

  def post_response(headers, response)
    client.puts headers
    client.puts response
    client.close
  end
end
