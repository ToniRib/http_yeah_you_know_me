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
end
