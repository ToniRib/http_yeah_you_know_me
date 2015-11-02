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

  def post_response(i)
    client.puts "Hello, World! (#{i})"
    client.close
  end
end

ch = ClientHandler.new
# machine = Machine.new
i = 0

loop do
  request = ch.get_request
  # puts request
  # response = ch.machine.generate_response(request)
  ch.post_response(i)
  i += 1 if request.first.include?("favicon")
end
