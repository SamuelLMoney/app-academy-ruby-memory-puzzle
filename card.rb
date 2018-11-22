# Abstraction
# Encapsulation

# good, come back to possible private methods, and questions post

class Card
  attr_reader :face_down, :value

  def initialize(value=nil)
    @value = value || rand(1..10)
    @face_down = true
  end

  def display # private? private is to let developer know that method should only be called inside its class. it's not going to be used with public interface and won't be "traveling" to other classes. and yeah i think this one private, why would i ever display a card without making it face up?
    return @value unless @face_down
  end

  def hide
    @face_down = true
  end

  def reveal
    @face_down = false
    display
  end

  def face_up
    !@face_down
  end

  def to_s
    @value.to_s # why is this necessary? o i think to make syntax easier for when i call.to_s on a card cuz i'll always want the value, not face_down for that
  end

  # def ==(other_card) # this breaks my sample! method for some reason. maybe ask about this cuz idk why
  #   self.to_s == other_card.to_s
  #   # self.to_s == gets.chomp ?
  # end


end
