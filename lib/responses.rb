require_relative 'word_search'

class Responses
  def hello_world(i)
    "Hello, World (#{i})"
  end

  def good_luck
    'Good luck!'
  end

  def root
    ''
  end

  def shutdown(i)
    "Total Requests: #{i}"
  end

  def datetime
    # 11:07AM on Sunday, November 1, 2015
    Time.now.strftime('%l:%M%p on %A, %B %e, %Y')
  end

  def word_search(word)
    if WordSearch.new.word?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

  def word_suggest(word)
    ws = WordSearch.new
    suggestions = ws.suggest(word)
    if ws.word?(word)
      "{\"word\":\"#{word}\",\"is_word\":true}"
    else
      "{\"word\":\"#{word}\",\"is_word\":false,\"possible_matches\":#{suggestions}}"
    end
  end

  def game_in_progress
    'There is already a game in progress.'
  end

  def system_error
    fail SystemStackError, "500 INTERNAL SERVER ERROR", caller
    rescue SystemStackError => e
    stack = e.backtrace.join("\n")
    "500 INTERNAL SERVER ERROR\n" + stack
  end

  def game(post_redirect, game)
    if post_redirect
      case game.check_guess
      when :too_low
        line = "Your guess was too low!"
      when :correct
        line = "Your guess was correct!"
      when :too_high
        line = "Your guess was too high!"
      when :no_guesses
        line = "Good Luck!"
      end
    else
      line = ''
    end

    line + "\n" + "Number of Guesses: #{game.number_of_guesses}"
  end
end
