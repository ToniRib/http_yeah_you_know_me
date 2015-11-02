class App
  def hello_world(i)
    "Hello, World (#{i})"
  end

  def convert_request_to_html(request)
    verb = request.first.split[0]
    path = request.first.split[1]
    protocol = request.first.split[2]
    host = request[1].split[1].split(":").first
    port = request[1].split[1].split(":").last
    accept = request[4]
    data = ["Verb: #{verb}", "Path: #{path}", "Protocol: #{protocol}",
     "Host: #{host}", "Port: #{port}", "Origin: #{host}",
     accept]
    "<pre>#{data.join("\n")}</pre>"
  end
end
