require "byebug"
require_relative "card"
require_relative "array_monkey"

# Abstraction
# Encapsulation

class Board
  LENGTH = 4 # using constant size for now. can change later. getting a bug with this constant for some reason?

  attr_reader :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) }
    # @hidden_grid = [] # nec? i don't think so, already storing all data in card object
  end

  def populate!
    first_half = Array.new(4 * 4 / 2) { Card.new }
    all = card_factory(first_half)

    @grid.map! do |row|
      row.map! do |ele|
        all.sample!
      end
    end
  end

  def render
    @grid.each do |row|
      displayed_row = []
      row.each do |card|
        if card.face_down
          displayed_row << "?"
        else
          displayed_row << card.value
        end
      end
      p displayed_row
    end
  end

  def won?
    @grid.all? do |row|
      row.all? do |card|
        card.face_up
      end
    end
  end

  def reveal(guessed_pos) # input in form[0, 0]
    guessed_card = self[guessed_pos]
    if guessed_card.face_down
      guessed_card.reveal
      return guessed_card.display
    end
  end

  # helper methods

  def card_factory(first_half) # private?
    second_half = []
    first_half.each do |card|
      second_half << Card.new(card.value)
    end
    first_half + second_half
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value) # if nec
    row, col = pos
    @grid[row][col] = value
  end

  # debugging methods

  def reveal_all
    @grid.each do |row|
      row.each do |card|
        card.reveal
      end
    end
  end

  def hide_all
    @grid.each do |row|
      row.each do |card|
        card.hide
      end
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  a = Board.new
  a.populate!
  a.render
  puts "---------"
  puts a.won?
  # a.reveal("0 0")
  # byebug
  a.reveal([0, 0])
  a.render
  puts "---------"
  # a.reveal("1 1")
  a.reveal([1, 1])
  a.render
  puts "---------"
  # a.reveal("2 2")
  a.reveal([2, 2])
  a.render
  puts "---------"
  # a.reveal("3 3")
  a.reveal([3, 3])
  a.render
  puts "---------"
  # a.reveal("0 3")
  a.reveal([0, 3])
  a.render
  puts "---------"
  a.reveal_all
  a.render
  puts a.won?
end
