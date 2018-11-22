require "byebug"
require_relative "card"
require_relative "board"

# Abstraction
# Encapsulation

class HumanPlayer

  def initialize
    @points = 0 # ?

  end


  def get_guess
    puts "please make a guess in the form 0 0"
    gets.chomp.split.map(&:to_i)
  end



end
