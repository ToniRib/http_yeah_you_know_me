require 'minitest'
require 'header_generator'

class HeaderGeneratorTest < Minitest::Test

  def setup
    @generator = HeaderGenerator.new
  end

  def test_it_generates_header_with_default_status_code
    expected = ["http/1.1 200 OK",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: 70\r\n\r\n"].join("\r\n")

    assert_equal expected, @generator.headers(70, '200 OK')
  end

  def test_it_generates_header_with_other_status_code
    expected = ["http/1.1 404 NOT FOUND",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: 70\r\n\r\n"].join("\r\n")

    assert_equal expected, @generator.headers(70, '404 NOT FOUND')
  end

  def test_it_generates_proper_header_for_redirect
    expected = ["http/1.1 301 MOVED PERMANENTLY",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "location: http://127.0.0.1:9292/game?word=post",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: 70\r\n\r\n"].join("\r\n")

    assert_equal expected, @generator.headers(70, '301 MOVED PERMANENTLY')
  end
end
