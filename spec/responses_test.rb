require 'minitest'
require 'responses'

class ResponsesTest < Minitest::Test
  def setup
    @responses = Responses.new
  end

  def test_generates_hello_world_zero_response
    expected = "Hello, World (0)"

    assert_equal expected, @responses.hello_world(0)
  end

  def test_generates_hello_world_with_different_response
    expected = "Hello, World (1)"

    assert_equal expected, @responses.hello_world(1)
  end

  #more tests

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
