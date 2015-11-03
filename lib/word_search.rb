require_relative 'complete_me'

class WordSearch
  def initialize
    @complete_me = CompleteMe.new
    dictionary = ['pizza']
    @complete_me.populate(dictionary)
  end

  def response(word)
    if word?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

  def word?(word)
    begin
      @complete_me.center.search(word).valid_word
    rescue
      false
    end
  end
end
