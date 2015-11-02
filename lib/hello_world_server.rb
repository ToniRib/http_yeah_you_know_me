require 'socket'
require 'pry'

tcp_server = TCPServer.new(9292)

i = 0

loop do
  client = tcp_server.accept
  puts "Sending response."
  response = "<pre>" + "Hello, World! (#{i})" + "</pre>"
  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output

  puts ["Wrote this response:", headers, output].join("\n")
  i += 1
end

client.close
puts "\nResponse complete, exiting."
