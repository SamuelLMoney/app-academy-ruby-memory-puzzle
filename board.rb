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
    all = first_half + first_half

    @grid.map! do |row|
      row.map! do |ele|
        all.sample!
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
