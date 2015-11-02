require 'minitest/autorun'
require 'minitest/pride'
require './lib/app'

class AppTest < Minitest::Test
  def setup
    @app = App.new
  end

  def test_generates_hello_world_zero_response
    expected = "Hello, World (0)"

    assert_equal expected, @app.hello_world(0)
  end

  def test_generates_hello_world_with_different_response
    expected = "Hello, World (1)"

    assert_equal expected, @app.hello_world(1)
  end

  def test_generates_html_from_request
    request = ["GET / HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<pre>\n#{request_data.join("\n")}\n</pre>"

    assert_equal expected, @app.convert_request_to_html(request)
  end

  def test_generates_hello_world_response_with_diagnostics
    request = ["GET / HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "Hello, World (0)\n<pre>\n#{request_data.join("\n")}\n</pre>"

    assert_equal expected, @app.generate_response(0, request)
  end
end
