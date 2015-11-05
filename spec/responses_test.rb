require 'minitest'
require 'responses'
require 'game'

class ResponsesTest < Minitest::Test
  def setup
    @responses = Responses.new
    @game = Game.new
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

  def test_game_responds_to_low_guess_from_post_redirect
    expected = "Your guess was too low!\nNumber of Guesses: 1"

    @game.answer = 7
    @game.store_guess(1)
    assert_equal expected, @responses.game('post', @game)
  end

  def test_game_responds_to_high_guess_from_post_redirect
    expected = "Your guess was too high!\nNumber of Guesses: 1"

    @game.answer = 7
    @game.store_guess(8)
    assert_equal expected, @responses.game('post', @game)
  end

  def test_game_responds_to_correct_guess_from_post_redirect
    expected = "Your guess was correct!\nNumber of Guesses: 1"

    @game.answer = 7
    @game.store_guess(7)
    assert_equal expected, @responses.game('post', @game)
  end

  def test_game_responds_to_no_guess_from_start_of_game
    expected = "Good Luck!\nNumber of Guesses: 0"

    @game.answer = 7
    assert_equal expected, @responses.game('post', @game)
  end

  def test_game_responds_with_number_of_guesses
    expected1 = "Your guess was too low!\nNumber of Guesses: 1"

    @game.answer = 7
    @game.store_guess(6)
    assert_equal expected1, @responses.game('post', @game)

    expected2 = "Your guess was too high!\nNumber of Guesses: 2"

    @game.store_guess(8)
    assert_equal expected2, @responses.game('post', @game)
  end

  def test_game_response_with_game_already_in_progress
    assert_equal 'There is already a game in progress.', @responses.game_in_progress
  end

  def test_game_response_with_no_game_started
    assert_equal 'There is no game started yet. POST to start_game to begin.', @responses.no_game_started
  end

  def test_displays_json_for_valid_word
    expected = "{\"word\":\"pizza\",\"is_word\":true}"

    assert_equal expected, @responses.word_suggest('pizza')
  end

  def test_displays_json_suggestions_for_word_fragment
    expected = "{\"word\":\"piz\",\"is_word\":false,\"possible_matches\":[\"pizzle\", \"pizzicato\", \"pizzeria\", \"pizza\", \"pize\"]}"

    assert_equal expected, @responses.word_suggest('piz')
  end
end
