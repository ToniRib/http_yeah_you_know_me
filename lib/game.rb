class Game
  attr_accessor :answer

  def initialize
    @answer = (1..10).to_a.sample
    @guesses = []
  end

  def store_guess(number)
    @guesses << number
  end

  def check_guess
    case @guesses.last <=> answer
    when -1 then  :too_low
    when 0  then  :correct
    when 1  then  :too_high
    end
  end

  def number_of_guesses
    @guesses.count
  end
end
