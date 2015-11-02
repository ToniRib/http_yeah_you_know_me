require 'socket'
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

    request_lines
  end

  def post_response(response)
    client.puts response
    client.close
  end
end

class App
  def generate_response(i)
    "Hello, World (#{i})"
  end
end

ch = ClientHandler.new
app = App.new
i = 0

loop do
  request = ch.get_request
  response = app.generate_response(i)
  ch.post_response(response)
  i += 1 if request.first.include?("favicon")
end
