require 'minitest'
require 'responses'

class ResponsesTest < Minitest::Test
  def setup
    @responses = Responses.new
  end

  def test_generates_hello_world_response
    expected = "Hello, World (0)"

    assert_equal expected, @responses.hello_world(0)
  end

  def test_generates_hello_world_different_response
    expected = "Hello, World (1)"

    assert_equal expected, @responses.hello_world(1)
  end

  def test_generates_good_luck_response
    assert_equal 'Good luck!', @responses.good_luck
  end

  def test_generates_empty_string_for_root_response
    assert_equal '', @responses.root
  end

  def test_generates_shutdown_response
    assert_equal 'Total Requests: 1', @responses.shutdown(1)
  end

  def test_generates_different_shutdown_response
    assert_equal 'Total Requests: 5', @responses.shutdown(5)
  end

  def test_generates_datetime_response
    today = Time.now.strftime('%l:%M%p on %A, %B %e, %Y')

    assert_equal today, @responses.datetime
  end

  def test_responds_with_known_word_if_word_is_pizza
    expected = "pizza is a known word"

    assert_equal expected, @responses.word_search('pizza')
  end

  def test_responds_with_unknown_word_if_word_is_pizz
    expected = "pizz is not a known word"

    assert_equal expected, @responses.word_search('pizz')
  end

  def test_responds_with_unknown_word_if_word_is_random_chars
    expected = "jfesaiovewuoa is not a known word"

    assert_equal expected, @responses.word_search('jfesaiovewuoa')
  end
end
