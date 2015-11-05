require 'minitest'
require 'app'
require 'pry'

class AppTest < Minitest::Test
  def setup
    @app = App.new
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

    expected = "<html><head></head><body><pre></pre><pre>#{request_data.join("\n")}</pre></body></html>"

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

    expected = "<html><head></head><body><pre>Hello, World (0)</pre><pre>#{request_data.join("\n")}</pre></body></html>"

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

    expected = "<html><head></head><body><pre>#{date_time}</pre><pre>#{request_data.join("\n")}</pre></body></html>"

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

    expected = "<html><head></head><body><pre>Total Requests: 5</pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(5, request)
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

    expected = "<html><head></head><body><pre>pizza is a known word</pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
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

    expected = "<html><head></head><body><pre>Good luck!</pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end

  def test_redirects_with_blank_response_when_POSTing_to_game
    start_game_request = ["POST /start_game HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection:keep-alive",
                         "Cache-Control: max-age=0",
                         "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                         "Upgrade-Insecure-Requests: 1",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                         "Accept-Encoding: gzip, deflate, sdch",
                         "Accept-Language: en-US,en;q=0.8"]

    @app.generate_response(0, start_game_request)

    request = ["POST /game HTTP/1.1",
      "Host: 127.0.0.1:9292",
      "Connection: keep-alive",
      "Content-Length: 137",
      "Cache-Control: no-cache", "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop", "Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryn7cI2d203SmjoASv", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Postman-Token: 5b2008d3-95bc-c135-abf7-a3494ead4942", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Accept-Encoding: gzip, deflate", "Accept-Language: en-US,en;q=0.8", "------WebKitFormBoundaryn7cI2d203SmjoASv", "Content-Disposition: form-data; name=\"guess\"", "5\r\n"]

    request_data = ["Verb: POST",
                    "Path: /game",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><pre></pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, request)
  end

  def test_gets_current_number_of_guesses_from_game
    start_game_request = ["POST /start_game HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection:keep-alive",
                         "Cache-Control: max-age=0",
                         "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                         "Upgrade-Insecure-Requests: 1",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                         "Accept-Encoding: gzip, deflate, sdch",
                         "Accept-Language: en-US,en;q=0.8"]

    @app.generate_response(0, start_game_request)

    game_post = ["POST /game HTTP/1.1",
      "Host: 127.0.0.1:9292",
      "Connection: keep-alive",
      "Content-Length: 137",
      "Cache-Control: no-cache", "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop", "Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryn7cI2d203SmjoASv", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Postman-Token: 5b2008d3-95bc-c135-abf7-a3494ead4942", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Accept-Encoding: gzip, deflate", "Accept-Language: en-US,en;q=0.8", "------WebKitFormBoundaryn7cI2d203SmjoASv", "Content-Disposition: form-data; name=\"guess\"", "5\r\n"]

    @app.generate_response(0, game_post)

    get_game_request = ["GET /game HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection:keep-alive",
                         "Cache-Control: max-age=0",
                         "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                         "Upgrade-Insecure-Requests: 1",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                         "Accept-Encoding: gzip, deflate, sdch",
                         "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /game",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><pre>\nNumber of Guesses: 1</pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, get_game_request)
  end

  def test_game_is_not_started_yet
    get_game_request = ["GET /game HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection:keep-alive",
                         "Cache-Control: max-age=0",
                         "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                         "Upgrade-Insecure-Requests: 1",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                         "Accept-Encoding: gzip, deflate, sdch",
                         "Accept-Language: en-US,en;q=0.8"]

    request_data = ["Verb: GET",
                    "Path: /game",
                    "Protocol: HTTP/1.1",
                    "Host: 127.0.0.1",
                    "Port: 9292",
                    "Origin: 127.0.0.1",
                    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"]

    expected = "<html><head></head><body><pre>There is no game started yet. POST to start_game to begin.</pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, get_game_request)
  end

  def test_game_is_already_in_progress
    start_game_request = ["POST /start_game HTTP/1.1",
                         "Host: 127.0.0.1:9292",
                         "Connection:keep-alive",
                         "Cache-Control: max-age=0",
                         "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                         "Upgrade-Insecure-Requests: 1",
                         "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                         "Accept-Encoding: gzip, deflate, sdch",
                         "Accept-Language: en-US,en;q=0.8"]

    @app.generate_response(0, start_game_request)

    start_game_request2 = ["POST /start_game HTTP/1.1",
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

    expected = "<html><head></head><body><pre>There is already a game in progress.</pre><pre>#{request_data.join("\n")}</pre></body></html>"

    assert_equal expected, @app.generate_response(0, start_game_request2)
  end
end
