require 'minitest/autorun'
require 'minitest/pride'
require './lib/app'
require 'pry'

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

  def test_generates_diagnostic_html_from_request
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

    expected = "<html><head></head><body><p></p><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end

  def test_generates_hello_world_response_with_diagnostics
    request = ["GET /hello HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /hello",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><p>Hello, World (0)</p><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end

  def test_generates_response_with_datetime_and_diagnostics
    request = ["GET /datetime HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /datetime",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    date_time = Time.now.strftime('%l:%M%p on %A, %B %e, %Y')

    expected = "<html><head></head><body><p>#{date_time}</p><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end

  def test_generates_shutdown_response_with_diagnostics
    request = ["GET /shutdown HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /shutdown",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><p>Total Requests: 5</p><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(5, request)
  end

  def test_split_path_and_rest_of_url
    request = ["GET /hello?bob"]

    assert_equal "/hello", @app.path(request)
  end

  def test_it_take_a_parameter
    request = ["GET /hello?word=value"]

    assert_equal 'value', @app.word(request)
  end

  def test_pizza_is_a_word
    assert @app.word?("pizza")
  end

  def test_pizz_is_not_a_word
    refute @app.word?("pizz")
  end

  def test_random_chars_is_not_a_word
    refute @app.word?("kasjlgisaejglsaknglasehg")
  end

  def test_responds_with_known_word_if_word_is_pizza
    expected = "pizza is a known word"

    assert_equal expected, @app.word_response('pizza')
  end

  def test_responds_with_unknown_word_if_word_is_pizz
    expected = "pizz is not a known word"

    assert_equal expected, @app.word_response('pizz')
  end

  def test_responds_with_unknown_word_if_word_is_random_chars
    expected = "jfesaiovewuoa is not a known word"

    assert_equal expected, @app.word_response('jfesaiovewuoa')
  end

  def test_server_word_query_asserts_pizza_is_a_word
    request = ["GET /word_search?word=pizza HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /word_search",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><p>pizza is a known word</p><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end

  def test_cannot_post_to_hello_path
    skip #deal when handling errors
    request = ["POST /hello HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]
    # binding.pry
    refute @app.generate_response(0, request)
  end

  def test_returns_good_luck_when_game_is_started
    request = ["POST /start_game HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: POST",
                    "Path: /start_game",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><p>Good luck!</p><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end
end
