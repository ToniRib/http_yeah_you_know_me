require 'socket'

class Server < TCPServer
  def build_response(idx)
    response = "<pre>Hello, World! (#{idx})</pre>"
    "<html><head></head><body>#{response}</body></html>"
  end
end
