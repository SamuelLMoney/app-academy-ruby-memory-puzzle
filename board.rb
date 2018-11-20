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
    @hidden_grid = [] # nec?
  end

  def populate!
    # byebug
    used = []

    first_half = Array.new(4 * 4 / 2) { Card.new } # remember to require other classes
    # first_half = Array.new(8) { Card.new }
    # byebug
    @grid.map! do |row|
      row.map! do |ele|
        # new_card = rand(1..10)
        if first_half.empty? # i think works but not truly random. can never get completed pair before going through first_half. actually even worse than that, this way makes 2nd half the same order as first half. bad. this works now but still not pefect randomness.
          used.sample!
        else
          new_card = first_half.sample!
          used << new_card
          new_card
        end
      end
    end

  end


  def render
    # p @grid # no i need to convert the card objects into an understandable output and take into account faceup/down

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
        !card.face_down
      end
    end
  end

  def reveal(guessed_pos) # input in form "0 0"
    # byebug
    i, j = guessed_pos[0].to_i, guessed_pos[-1].to_i
    guessed_card = @grid[i][j]
    # byebug
    if guessed_card.face_down
      # byebug
      guessed_card.reveal
      return guessed_card.display
    end
  end


end
