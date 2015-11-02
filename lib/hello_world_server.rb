require_relative 'server'
require 'pry'

tcp_server = Server.new(9292)

i = 0

loop do
  client = tcp_server.accept

  output = tcp_server.build_response(i)
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")

  client.puts headers
  client.puts output

  i += 1
end

client.close
