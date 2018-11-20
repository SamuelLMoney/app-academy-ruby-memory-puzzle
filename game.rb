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
  end

  def play
    @board.populate!

    until self.over?
      @board.render
      guess = get_guess
      initial_guess(guess)
      guess = get_guess
      matching_guess(guess)
      puts "you win!" if self.over?
      system("clear")
    end
  end

  def get_guess
    puts "please make a guess in the form 0 0"
    gets.chomp.split.map(&:to_i) # keep in string form? maybe keep in string form since Card.to_s method
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
