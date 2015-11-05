require_relative 'complete_me'

class WordSearch
  def initialize
    @complete_me = CompleteMe.new
    dictionary = ['pizza']
    @complete_me.populate(dictionary)
  end

  def word?(word)
    begin
      @complete_me.center.search(word).valid_word
    rescue
      false
    end
  end

  def suggest(word)
    @complete_me.suggest(word)
  end
end
