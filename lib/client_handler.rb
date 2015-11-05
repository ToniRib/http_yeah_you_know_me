require 'socket'
require_relative 'app'

class ClientHandler
  attr_reader :server, :client

  def initialize(port = 9292)
    @server = TCPServer.open(port)
  end

  def get_request
    @client = server.accept
    request = []

    move_headers_into(request)
    move_body_into(request) if content_is_set_on(request)

    return request
  end

  def move_headers_into(request)
    move_next_block_of_lines_into(request)
  end

  def move_body_into(request)
    move_next_block_of_lines_into(request)
    request << client.gets
  end

  def move_next_block_of_lines_into(request)
    while line = client.gets and !line.chomp.empty?
      request << line.chomp
    end
  end

  def content_is_set_on(request)
    request.join.include?('Content-Type')
  end

  def post_response(headers, response)
    client.puts headers
    client.puts response
    client.close
  end
end
