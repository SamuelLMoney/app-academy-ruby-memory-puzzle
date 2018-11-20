# Abstraction
# Encapsulation

class Card
  attr_reader :face_down, :value

  def initialize(value=nil) # not sure if auto nil is necessary anymore
    @value = value || rand(1..10)
    @face_down = true
  end

  def display
    return @value unless @face_down
  end

  def hide
    @face_down = true
  end

  def reveal
    @face_down = false
    display
  end

  def to_s
    @value.to_s # why is this necessary? o i think to make syntax easier for when i call.to_s on a card cuz i'll always want the value, not face_down for that
  end

  def ==(other_card)
    self.to_s == other_card.to_s
    # self.to_s == gets.chomp ?
  end


end
