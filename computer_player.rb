require "byebug"
require "set"
# require_relative "board" # it can interact with board/game by passing values from those classes to here rather than requiring them and accessing values directly. think it's better for flow to only be one way for safety.

class ComputerPlayer
  attr_reader :known_cards, :matched_cards

  def initialize
    @known_cards = {}
    @matched_cards = Set[]
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(pos1, pos2)
    @matched_cards.add([pos1, pos2])
    # then remove those cards from known cards i think
    @known_cards.delete(pos1)
    @known_cards.delete(pos2)
  end

  # make 2 separate methods for initial and matching guess?

  def make_guess
    return get_first_match if knows_match?
    # else do a random guess with a card it hasn't seen
  end

  def knows_match? # p
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

  def get_first_match # will return in form [[0, 0], [1, 1]]
    first_matching_value = get_first_matching_value
    first_match = []
    # until first_match.length == 2
      @known_cards.each do |pos, value|
        first_match << pos if value == first_matching_value
        return first_match if first_match.length == 2
      end
    # end

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
