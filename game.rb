require "byebug"
require_relative "card"
require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game
  attr_reader :board, :prev_guess

  def initialize(human_player, computer_player)
    @board = Board.new
    @board.populate!
    @human_player = human_player
    @computer_player = computer_player
    @prev_guess = nil
    @currently_revealed = nil
  end

  def play
    until self.over?
      @board.render
      initial_guess
      matching_guess
      # byebug
      system("clear")
      p @computer_player.known_cards
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
    guess = get_guess_and_validate
    store_prev_guess(guess)
    try_guess_and_show(guess)
  end

  def matching_guess
    guess = get_guess_and_validate
    try_guess_and_show(guess)
    if match?(guess)
      correct_match
    else
      incorrect_match(guess)
    end
  end

  def over?
    @board.won?
  end

  private

  def try_guess_and_show(guess)
    @board.reveal(guess)
    @computer_player.receive_revealed_card(guess, @board[guess].value)
    @board.render
  end

  def get_guess_and_validate
    guess = @human_player.get_guess
    until valid?(guess)
      puts "that's not a valid guess..."
      guess = @human_player.get_guess
    end
    guess
  end

  def correct_match
    puts "yuppers!"
    sleep(2)
    if over?
      puts "you win!"
      sleep(2)
    end
  end

  def incorrect_match(guess)
    puts "nope!"
    sleep(2)
    @prev_guess.hide
    @board[guess].hide
  end

  def match?(guess)
    @board[guess].value == @prev_guess.value
  end

end


if __FILE__ == $PROGRAM_NAME
  h = HumanPlayer.new
  bot = ComputerPlayer.new
  a = Game.new(h, bot)
  a.play
end
