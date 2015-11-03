require 'minitest'
require 'word_search'

class WordSearchTest < Minitest::Test
  def setup
    @word_search = WordSearch.new
  end

  def test_pizza_is_a_word
    assert @word_search.word?("pizza")
  end

  def test_pizz_is_not_a_word
    refute @word_search.word?("pizz")
  end

  def test_random_chars_is_not_a_word
    refute @word_search.word?("kasjlgisaejglsaknglasehg")
  end

  def test_responds_with_known_word_if_word_is_pizza
    expected = "pizza is a known word"

    assert_equal expected, @word_search.word_response('pizza')
  end

  def test_responds_with_unknown_word_if_word_is_pizz
    expected = "pizz is not a known word"

    assert_equal expected, @word_search.word_response('pizz')
  end

  def test_responds_with_unknown_word_if_word_is_random_chars
    expected = "jfesaiovewuoa is not a known word"

    assert_equal expected, @word_search.word_response('jfesaiovewuoa')
  end
end
