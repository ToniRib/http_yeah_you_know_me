require_relative 'server'
require 'pry'

tcp_server = Server.new(9292)

i = 0

loop do
  client = tcp_server.accept

  # binding.pry
  output = tcp_server.build_response(i)
  headers = tcp_server.headers(output)

  client.puts headers
  client.puts output

  i += 1
end

client.close
