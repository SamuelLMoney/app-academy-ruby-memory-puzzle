# good, come back to questions post

class Card
  attr_reader :face_down, :value

  def initialize(value=nil)
    @value = value || rand(1..10)
    @face_down = true
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

  # def to_s
  #   @value.to_s # why is this necessary? o i think to make syntax easier for when i call.to_s on a card cuz i'll always want the value, not face_down for that
  # end

  # def ==(other_card) # this breaks my sample! method for some reason. maybe ask about this cuz idk why. yeah verified again this breaks my sample!, no idea why. it breaks it without me even calling it as far as i can tell
  #   self.value == other_card.value
  #   # self.to_s == gets.chomp ?
  # end

  private

  def display
    return @value unless @face_down
  end

end
