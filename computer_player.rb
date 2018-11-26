require "byebug"
require "set"
# require_relative "board" # it can interact with board/game by passing values from those classes to here rather than requiring them and accessing values directly. think it's better for flow to only be one way for safety.


class ComputerPlayer
  attr_reader :known_cards, :matched_cards

  def initialize
    @known_cards = {}
    @matched_cards = Set[]
    @initial_guess = nil
    @matching_guess = nil
    @tries = 0
    @last_guess = nil
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(pos1, pos2)
    @matched_cards.add(pos1)
    @matched_cards.add(pos2)
    # then remove those cards from known cards
    @known_cards.delete(pos1)
    @known_cards.delete(pos2)
  end

  def get_first_guess # use the same method name so no matter if it's passed a human or bot it'll work
    puts "please make a guess in the form 0 0"
    sleep(1)

    if knows_match?
      get_first_match
      p @initial_guess
      sleep(1)
      return @initial_guess
    end
    # else do a random guess with a card it hasn't seen
    guess = random_guess
    @last_guess = guess
    p guess
    sleep(1)
    guess
  end

  def get_matching_guess
    puts "please make a guess in the form 0 0"
    sleep(1)

    if knows_match?
      get_first_match

      unless @matching_guess == @last_guess
        p @matching_guess
        sleep(1)
        return @matching_guess
      end

      p @initial_guess
      sleep(1)
      return @initial_guess
    end

    guess = random_guess
    p guess
    sleep(1)
    guess
  end

  def random_guess
    guess = [rand(0..3), rand(0..3)]
    until not_yet_seen?(guess)
      guess = [rand(0..3), rand(0..3)]
    end
    guess
  end

  def not_yet_seen?(guess) # priv
    !@known_cards.key?(guess) && !@matched_cards.include?(guess)
  end

  def knows_match? # priv
    @known_cards.values.uniq != @known_cards.values
  end

  def get_first_matching_value
    count = get_count
    count.each do |value, times_seen|
      if times_seen > 1
        return value
      end
    end
  end

  def get_first_match # will return in form [[0, 0], [1, 1]]. first match pos 1?
    first_matching_value = get_first_matching_value
    first_match = []
    @known_cards.each do |pos, value|
      first_match << pos if value == first_matching_value
      if first_match.length == 2
        @initial_guess = first_match.first
        @matching_guess = first_match.last
        break # ?
      end
    end
  end

  def get_count
    count = Hash.new(0)
    @known_cards.each_value do |value|
      count[value] += 1
    end
    count
  end

  def set_count # debugging
    @known_cards = { [0, 0] => 1, [0, 1] => 8, [3, 3] => 4, [1, 2] => 2, [2, 2] => 8 }
  end

end
