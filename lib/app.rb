require 'pry'

class App
  def hello_world(i)
    "Hello, World (#{i})"
  end

  def convert_request_to_html(request)
    data = ["Verb: #{verb(request)}", "Path: #{path(request)}",
            "Protocol: #{protocol(request)}", "Host: #{host(request)}",
            "Port: #{port(request)}", "Origin: #{host(request)}", "#{accept(request)}"]
    create_html_string(data)
  end

  def create_html_string(data)
    "<pre>\n#{data.join("\n")}\n</pre>"
  end

  def generate_response(i, request)
    case path(request)
    when '/'
      convert_request_to_html(request)
    when '/hello'
      hello_world(i) + "\n" + convert_request_to_html(request)
    end
  end

  def verb(request)
    request.first.split[0]
  end

  def path(request)
    request.first.split[1]
  end

  def protocol(request)
    request.first.split[2]
  end

  def host(request)
    request[1].split[1].split(":")[0]
  end

  def port(request)
    request[1].split[1].split(":")[1]
  end

  def accept(request)
    request[4]
  end
end
