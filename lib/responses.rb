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

  def game(sym, num_guesses)
    case sym
    when :too_low
      line = "Your guess was too low!"
    when :correct
      line = "Your guess was correct!"
    when :too_high
      line = "Your guess was too high!"
    else
      line = ''
    end
    line + "\n" + "Number of Guesses: #{num_guesses}"
  end
end
