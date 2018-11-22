require "byebug"
require "set"
# require_relative "board" # it can interact with board/game by passing values from those classes to here rather than requiring them and accessing values directly. think it's better for flow to only be one way for safety.

class ComputerPlayer
  attr_reader :known_cards, :matched_cards

  def initialize
    # @memory = nil
    @known_cards = {}
    @matched_cards = Set[]
  end

  # def update_memory
  #
  # end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(pos1, pos2)
    @matched_cards.add(pos1, pos2)
  end

  def make_guess
    get_first_match if knows_match?
  end

  def knows_match?
    @known_cards.values.uniq != @known_cards.values
  end

  def get_first_match
    count = get_count
    matching_value = nil
    count.each do |value, num|
      
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
    @known_cards = { [0, 0] => 1, [0, 1] => 8, [3, 3] => 4, [1, 2] => 1 }
  end

end
