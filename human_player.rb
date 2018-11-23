require "byebug"

class HumanPlayer

  def get_guess
    puts "please make a guess in the form 0 0"
    gets.chomp.split.map(&:to_i)
  end

end


  # def initialize # don't need this?
  #   @points = 0 # ?
  # end
