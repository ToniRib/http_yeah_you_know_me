require 'minitest'
require 'request_parser'

class RequestParserTest < Minitest::Test
  def setup
    @parser = RequestParser.new
    @request1 = ["GET /shutdown HTTP/1.1",
               "Host: 127.0.0.1:9292",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]

    @request2 = ["POST /word_search?word=pizza HTTP/2.0",
               "Host: 127.0.55.1:2323",
               "Connection:keep-alive",
               "Cache-Control: max-age=0",
               "Accept: application/json,text/html,application/xhtml+xml,application/xml;q=0.9",
               "Upgrade-Insecure-Requests: 1",
               "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
               "Accept-Encoding: gzip, deflate, sdch",
               "Accept-Language: en-US,en;q=0.8"]
  end

  def test_recognizes_the_verb
    assert_equal 'GET', @parser.verb(@request1)
  end

  def test_recognizes_a_different_verb
    assert_equal 'POST', @parser.verb(@request2)
  end

  def test_recognizes_a_path
    assert_equal '/shutdown', @parser.path(@request1)
  end

  def test_recognizes_a_different_path
    assert_equal '/word_search', @parser.path(@request2)
  end

  def test_returns_nil_if_no_word_present
    refute @parser.word(@request1)
  end

  def test_recognizes_a_word
    assert_equal 'pizza', @parser.word(@request2)
  end

  def test_recognizes_a_different_word
    request = ["POST /word_search?word=hello HTTP/2.0"]

    assert_equal 'hello', @parser.word(request)
  end

  def test_recognizes_a_protocol
    assert_equal 'HTTP/1.1', @parser.protocol(@request1)
  end

  def test_recognizes_a_different_protocol
    assert_equal 'HTTP/2.0', @parser.protocol(@request2)
  end

  def test_recognizes_a_host
    assert_equal '127.0.0.1', @parser.host(@request1)
  end

  def test_recognizes_a_different_host
    assert_equal '127.0.55.1', @parser.host(@request2)
  end

  def test_recognizes_a_port
    assert_equal '9292', @parser.port(@request1)
  end

  def test_recognizes_a_different_port
    assert_equal '2323', @parser.port(@request2)
  end

  def test_recognizes_an_accept
    expected = "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    assert_equal expected, @parser.accept(@request1)
  end

  def test_recognizes_a_different_accept
    expected = "Accept: application/json,text/html,application/xhtml+xml,application/xml;q=0.9"
    assert_equal expected, @parser.accept(@request2)
  end

  def test_creates_string_of_diagnostics
    expected = ["Verb: GET",
                "Path: /shutdown",
                "Protocol: HTTP/1.1",
                "Host: 127.0.0.1",
                "Port: 9292",
                "Origin: 127.0.0.1",
                "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"].join("\n")

    assert_equal expected, @parser.diagnostics(@request1)
  end

  def test_creates_other_string_of_diagnostics
    expected = ["Verb: POST",
                "Path: /word_search",
                "Protocol: HTTP/2.0",
                "Host: 127.0.55.1",
                "Port: 2323",
                "Origin: 127.0.55.1",
                "Accept: application/json,text/html,application/xhtml+xml,application/xml;q=0.9"].join("\n")

    assert_equal expected, @parser.diagnostics(@request2)
  end
end
