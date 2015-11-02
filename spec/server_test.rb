require 'minitest/test'
require 'minitest/pride'
require './lib/server'
require 'socket'

class ServerTest < Minitest::Test
  def test_can_create_a_tcp_server_object
    server = Server.new(9292)
    assert server.is_a?(TCPServer)
  end

  def test_server_can_create_a_html_response
    server = Server.new(9292)

    response = "<pre>Hello, World! (0)</pre>"
    expected_output = "<html><head></head><body>#{response}</body></html>"

    assert_equal expected_output, server.build_response(0)
  end
end
