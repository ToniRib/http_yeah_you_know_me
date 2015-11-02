class App
  def hello_world(i)
    "Hello, World (#{i})"
  end

  def convert_request_to_html(request)
    verb, path, protocol = request.first.split
    host, port = request[1].split[1].split(":")
    accept = request[4]
    data = ["Verb: #{verb}", "Path: #{path}", "Protocol: #{protocol}",
     "Host: #{host}", "Port: #{port}", "Origin: #{host}",
     accept]
    "<pre>\n#{data.join("\n")}\n</pre>"
  end

  def generate_response(i, request)
    hello_world(i) + "\n" + convert_request_to_html(request)
  end
end
