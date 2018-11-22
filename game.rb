require "byebug"
require_relative "card"
require_relative "board"

# Abstraction
# Encapsulation

class Game
  attr_reader :board, :prev_guess

  def initialize
    @board = Board.new
    @prev_guess = nil
    @currently_revealed = nil
  end

  def play
    @board.populate!

    until self.over?
      @board.render
      guess = get_guess
      initial_guess(guess)
      guess = get_guess
      matching_guess(guess)
      system("clear")
    end
  end

  def get_guess
    puts "please make a guess in the form 0 0"
    guess = gets.chomp.split.map(&:to_i)
    if valid?(guess)
      return guess
    end
    puts "that's not a valid guess..."
    get_guess
  end

  def valid?(guess) # could further optimize by taking into account guesses not in the form "0 0" but will leave like this for now
    possible = (0..3) # check if in valid form
    guess.each do |num|
      return false unless possible.include?(num)
    end
    @currently_revealed = @board.currently_revealed
    return false if @currently_revealed.include?(guess)
    true
  end

  def store_prev_guess(guess)
    @prev_guess = @board[guess]
  end

  def initial_guess(guess)
    store_prev_guess(guess)
    @board.reveal(guess)
    @board.render
  end

  def matching_guess(guess)
    @board.reveal(guess)
    @board.render
    if @board[guess].value != @prev_guess.value
      puts "nope!"
      sleep(2)
      @prev_guess.hide
      @board[guess].hide
    else
      puts "yuppers!"
      sleep(2)
      if over?
        puts "you win!"
        sleep(2)
      end
    end
  end

  def over?
    @board.won?
  end

end


if __FILE__ == $PROGRAM_NAME
  a = Game.new
  a.play
end
