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
end
