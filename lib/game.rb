class Game
  attr_accessor :answer

  def initialize
    @answer = (1..10).to_a.sample
    @guesses = []
  end

  def guess(number)
    @guesses << number
    case number <=> answer
    when -1 then  :too_low
    when 0  then  :correct
    when 1  then  :too_high
    end
  end

  def number_of_guesses
    @guesses.count
  end
end
