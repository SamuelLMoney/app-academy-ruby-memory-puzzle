require "byebug"
require_relative "card"
require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game
  attr_reader :board, :prev_guess

  def initialize(player)
    @board = Board.new
    @board.populate!

    # @human_player = human_player
    # @computer_player = computer_player

    @player = player

    @prev_guess = nil
    @prev_guess_pos = nil
    @currently_revealed = nil
  end

  def play
    until self.over?
      @board.render
      initial_guess
      p @player.known_cards
      p @player.matched_cards
      # sleep(2)
      matching_guess
      # byebug
      system("clear")
      p @player.known_cards
      p @player.matched_cards
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
    @prev_guess_pos = guess
  end

  def initial_guess
    # if human player
    guess = get_first_guess_and_validate
    store_prev_guess(guess)
    try_guess_and_show(guess)
  end

  def matching_guess
    guess = get_matching_guess_and_validate
    try_guess_and_show(guess)
    if match?(guess)
      correct_match(guess)
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
    @player.receive_revealed_card(guess, @board[guess].value)
    @board.render
  end

  def get_first_guess_and_validate
    guess = @player.get_first_guess # make 2 separate methods here so i can differentiate between 1st and 2nd guess?
    until valid?(guess)
      puts "that's not a valid guess..."
      guess = @player.get_first_guess
    end
    guess
  end

  def get_matching_guess_and_validate
    guess = @player.get_matching_guess # make 2 separate methods here so i can differentiate between 1st and 2nd guess?
    until valid?(guess)
      puts "that's not a valid guess..."
      guess = @player.get_matching_guess
    end
    guess
  end

  def correct_match(guess)
    puts "yuppers!"
    sleep(2)
    @player.receive_match(guess, @prev_guess_pos)
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
  # pass in only 1 at a time?
  # g = Game.new(h)
  g = Game.new(bot) # same exact code, just initialized with a human or a bot and can do either one, cool
  g.play
end
