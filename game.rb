require "byebug"
require_relative "card"
require_relative "board"
require_relative "human_player"

# Abstraction
# Encapsulation

# seems to be working at the moment if i make all valid moves. immediately breaks if i make an invalid move. wtf lol
# it's taking my most recent missed guess and circling back to try that. is it processing recursively? no it's just finishing the original method that never ended...
class Game
  attr_reader :board, :prev_guess

  def initialize(human_player)
    @board = Board.new
    @human_player = human_player
    @prev_guess = nil
    @currently_revealed = nil
  end

  def play
    @board.populate!

    until self.over?
      @board.render
      # guess = get_guess
      initial_guess
      # guess = get_guess
      matching_guess
      system("clear")
    end
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

  def initial_guess
    # if human player
    #byebug
    guess = @human_player.get_guess # might not even need this line now. actually still need to initialize guess although it might work with it as nil at first. might get an error when checking nil with valid? tho
    # unless valid?(guess)
    until valid?(guess)
      puts "that's not a valid guess..."
      guess = @human_player.get_guess
    end

    # if valid?(guess) == false
    #   puts "that's not a valid guess..."
    #   initial_guess # o wow that's pretty nuts. i never returned/break or anything so yeah it runs initial_guess again but it still needs to finish the rest of the original method. wow that was a mind blow.
    # end
    #byebug

    # if valid?(guess)
    #   return guess
    # end
    # puts "that's not a valid guess..."
    # get_guess

    store_prev_guess(guess)
    @board.reveal(guess)
    @board.render
    #byebug
  end

  def matching_guess
    #byebug
    guess = @human_player.get_guess

    until valid?(guess)
      puts "that's not a valid guess..."
      guess = @human_player.get_guess
    end
    # unless valid?(guess)
    # if valid?(guess) == false
    #   puts "that's not a valid guess..."
    #   matching_guess
    # end
    #byebug
    @board.reveal(guess)
    @board.render
    #byebug
    if @board[guess].value != @prev_guess.value
      puts "nope!"
      sleep(2)
      @prev_guess.hide
      @board[guess].hide
      #byebug
    else
      puts "yuppers!"
      sleep(2)
      if over?
        puts "you win!"
        sleep(2)
      end
      #byebug
    end
  end

  def over?
    @board.won?
  end

end


if __FILE__ == $PROGRAM_NAME
  h = HumanPlayer.new
  a = Game.new(h)
  a.play
end
