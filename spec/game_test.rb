require 'minitest'
require 'game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_game_generates_random_number_when_initialized
    assert @game.answer.is_a?(Fixnum)
  end

  def test_answer_is_between_one_and_ten
    assert (1..10).to_a.include?(@game.answer)
  end

  def test_game_takes_a_correct_guess
    @game.answer = 7
    @game.store_guess(7)

    assert_equal :correct, @game.check_guess
  end

  def test_game_takes_a_lower_guess
    @game.answer = 7
    @game.store_guess(5)

    assert_equal :too_low, @game.check_guess
  end

  def test_game_takes_a_higher_guess
    @game.answer = 7
    @game.store_guess(9)

    assert_equal :too_high, @game.check_guess
  end

  def test_game_starts_with_0_guesses
    assert_equal 0, @game.number_of_guesses
  end

  def test_game_tracks_number_of_guesses
    assert_equal 0, @game.number_of_guesses

    @game.store_guess(3)
    assert_equal 1, @game.number_of_guesses

    @game.store_guess(8)
    assert_equal 2, @game.number_of_guesses
  end
end
