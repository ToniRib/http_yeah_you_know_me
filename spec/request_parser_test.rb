require 'minitest'
require 'request_parser'

class RequestParserTest < Minitest::Test
  def setup
    request1 = ["GET /shutdown HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection: keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    request2 = ["POST /word_search?word=pizza HTTP/2.0",
               "Host: 127.0.55.1:2323",
               "Connection: keep-alive",
               "Accept: application/json,text/html,application/xhtml+xml,application/xml;q=0.9",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]
    @parser1 = RequestParser.new(request1)
    @parser2 = RequestParser.new(request2)
  end

  def test_recognizes_the_verb
    assert_equal 'GET', @parser1.verb
  end

  def test_recognizes_a_different_verb
    assert_equal 'POST', @parser2.verb
  end

  def test_recognizes_a_path
    assert_equal '/shutdown', @parser1.path
  end

  def test_recognizes_a_different_path
    assert_equal '/word_search', @parser2.path
  end

  def test_returns_nil_if_no_word_present
    refute @parser1.word
  end

  def test_recognizes_a_word
    assert_equal 'pizza', @parser2.word
  end

  def test_recognizes_a_different_word
    request = ["POST /word_search?word=hello HTTP/2.0",
               "Host: 127.0.55.1:2323",
               "Connection: keep-alive",
               "Accept: application/json,text/html,application/xhtml+xml,application/xml;q=0.9",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]
    parser = RequestParser.new(request)

    assert_equal 'hello', parser.word
  end

  def test_recognizes_a_protocol
    assert_equal 'HTTP/1.1', @parser1.protocol
  end

  def test_recognizes_a_different_protocol
    assert_equal 'HTTP/2.0', @parser2.protocol
  end

  def test_recognizes_a_host
    assert_equal '127.0.0.1', @parser1.host
  end

  def test_recognizes_a_different_host
    assert_equal '127.0.55.1', @parser2.host
  end

  def test_recognizes_a_port
    assert_equal '9292', @parser1.port
  end

  def test_recognizes_a_different_port
    assert_equal '2323', @parser2.port
  end

  def test_recognizes_an_accept
    expected = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    assert_equal expected, @parser1.accept
  end

  def test_recognizes_a_different_accept
    expected = "application/json,text/html,application/xhtml+xml,application/xml;q=0.9"
    assert_equal expected, @parser2.accept
  end

  def test_creates_string_of_diagnostics
    expected = ["Verb: GET",
                "Path: /shutdown",
                "Protocol: HTTP/1.1",
                "Host: 127.0.0.1",
                "Port: 9292",
                "Origin: 127.0.0.1",
                "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"].join("\n")

    assert_equal expected, @parser1.diagnostics
  end

  def test_creates_other_string_of_diagnostics
    expected = ["Verb: POST",
                "Path: /word_search",
                "Protocol: HTTP/2.0",
                "Host: 127.0.55.1",
                "Port: 2323",
                "Origin: 127.0.55.1",
                "Accept: application/json,text/html,application/xhtml+xml,application/xml;q=0.9"].join("\n")

    assert_equal expected, @parser2.diagnostics
  end
end
