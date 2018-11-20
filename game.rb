require "byebug"
require_relative "card"
require_relative "board"
require_relative "array_monkey"


# Abstraction
# Encapsulation

class Game
  attr_reader :board, :prev_guess

  def initialize
    @board = Board.new
    @prev_guess = nil
  end

  def play # main method that groups everything else i think
    # loop until game over
    # render board
    # prompt player for input
    # get guessed_pos
    # pass pos to a make_guess method
    # system("clear") before next guess
    # sleep(n) to show incorrect guess temprorarily

    @board.populate!

    until self.over?
      @board.render
      guess = get_guess
      # store_prev_guess(guess)
      # make_guess(guess)
      initial_guess(guess)
      guess = get_guess
      matching_guess(guess)
      # system("clear")
    end
  end

  def get_guess
    puts "please make a guess in the form 0 0"
    gets.chomp.split.map(&:to_i) # keep in string form? maybe keep in string form since Card.to_s method
  end

  def store_prev_guess(guess)
    @prev_guess = @board[guess]
  end

  def correct_guess?(guess)
      # guess == @board.reveal(guess)
      guess == @prev_guess
  end

  def make_guess(guess)
    # step = 0
    # if ?correct_guess?(guess)
      # @board[guess].

    # else
    #   sleep(2)
    #   @board[guess].hide
    # end

    initial_guess(guess)
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
